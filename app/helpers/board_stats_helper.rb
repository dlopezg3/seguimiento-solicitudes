module BoardStatsHelper

  def status_hash(cards, lists)
    status_hash = Hash.new(0)
    cards.each { |card| status_hash["#{list_for_card(lists, card)["name"]}"] += 1 }
    status_hash
  end

  def pluralize(hash, key)
    hash[key] == 1 ? key : "#{key}s"
  end
end
