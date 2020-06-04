module BoardStatsHelper

  def status_hash
    status_hash = Hash.new(0)
    @cards.each { |card| status_hash["#{list_for_card(card)["name"]}"] += 1 }
    status_hash
  end

  def pluralize(hash, key)
    hash[key] == 1 ? key : "#{key}s"
  end

  def secretarias_hash
    secretarias_hash = Hash.new(0)
    @cards.each do |card|
      if card["custom_info"]["Secretaría"].nil?
        secretarias_hash["Sin asignar"] += 1
      else
        secretarias_hash[card["custom_info"]["Secretaría"]] += 1
      end
    end
    secretarias_hash
  end

  def average_by_period_time(period = "days")
    @period_range = set_period_range(period)

    compute_ratio(counter_by_date(@cards), @days)
  end

  def calculate_ratio_by_period(status, period = "days")
    @period_range = set_period_range(period)
    counter = counter_by_date(@cards)
    factor = counter.positive? ? 100 : 1
    percentage = counter.positive? ? "%" : ""

    filtered_cards = @cards.select do |card|
      list_for_card(card)["name"] == status
    end

    "#{compute_ratio(counter_by_date(filtered_cards), counter, factor)}#{percentage} "
  end

  def count_totals(period = "days")
    @period_range = set_period_range(period)
    counter_by_date(@cards)
  end

  private

  def set_period_range(period)
    start_date = 7.send(period).ago.to_date
    end_date   = 0.send(period).ago.to_date
    @days = (end_date - start_date).to_f

    start_date..end_date
  end

  def counter_by_date(cards)
    @period_range.inject(0) do |sum, date|
      sum + cards.select{ |card| card["custom_info"]["Fecha de solicitud"].to_date == date }.size
    end
  end

  def compute_ratio(dividen, divisor, factor = 1)
    return "Na" unless divisor > 0

    (dividen / divisor.to_f * factor).round(2)
  end
end
