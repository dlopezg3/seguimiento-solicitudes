module BoardStatsHelper

  def status_hash(cards, lists)
    status_hash = Hash.new(0)
    cards.each { |card| status_hash["#{list_for_card(lists, card)["name"]}"] += 1 }
    status_hash
  end

  def pluralize(hash, key)
    hash[key] == 1 ? key : "#{key}s"
  end

  def secretarias_hash(cards)
    secretarias_hash = Hash.new(0)
    cards.each do |card|
      if card["custom_info"]["Secretaría"].nil?
        secretarias_hash["Sin asignar"] += 1
      else
        secretarias_hash[card["custom_info"]["Secretaría"]] += 1
      end
    end
    secretarias_hash
  end
end
