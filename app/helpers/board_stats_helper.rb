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

  def average_by_period_time(period)
    @period_range = set_period_range(period)

    (counter_by_date(@cards) / @days).round(2)
    compute_ratio(counter_by_date(@cards), @days)
  end

  def calculate_ratio_by_period(period, status)
    @period_range = set_period_range(period)

    filtered_cards = @cards.select do |card|
      list_for_card(card)["name"] == status
    end
    "#{compute_ratio(counter_by_date(filtered_cards),counter_by_date(@cards)) * 100}% "
  end

  private

  def set_period_range(period = "days")
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

  def compute_ratio(dividen, divisor)
    (dividen / divisor.to_f).round(2)
  end
end
