class Card < ApplicationRecord

  def self.fetch_trello_cards
    url = "https://api.trello.com/1/boards/5ec56063edc3f53f0c17f299/cards?key=#{ENV['TRELLO_KEY']}&token=#{ENV['TRELLO_TOKEN']}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    cards_array = separate_description_array(JSON.parse(response))
  end

  def self.sort_by_date(cards_array)
    cards_array = cards_array.sort_by { |hash| hash["dateLastActivity"] }.reverse!
  end

  private

  def self.separate_description_array(cards_array)
    cards_array.each do |hash|
      desc_hash = {}
      hash["desc"].split("\n").each do |element|
        hash["custom_info"] = create_description_hash(element, desc_hash)
      end
    end
    cards_array
  end

  def self.create_description_hash(element, desc_hash)
    return if element.empty?

    description_item_array = element.split(":", 2)
    desc_hash["#{description_item_array.first.strip}"] = description_item_array.last.strip
    desc_hash
  end
end
