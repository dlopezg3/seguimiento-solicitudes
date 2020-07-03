class Card < ApplicationRecord

  def self.fetch_trello_cards
    url = "https://api.trello.com/1/boards/5ec56063edc3f53f0c17f299/cards?key=#{ENV['TRELLO_KEY']}&token=#{ENV['TRELLO_TOKEN']}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    cards_array = separate_description_array(JSON.parse(response))
    cards_array.each do |card|
      secretary_name(card)
    end
  end

  def self.sort_by_date(cards_array)
    cards_array = cards_array.sort_by { |hash| hash["dateLastActivity"] }.reverse!
  end

  def self.secretary_filter(cards, params)
    secretaria = params["secretaria"]
    cards = cards.select { |card| card["custom_info"]["Secretaría"] == secretaria }
  end

  private

  def self.separate_description_array(cards_array)
    cards_array.each do |hash|
      desc_hash = {}
      hash["desc"].gsub("**", "").gsub("\n\n", "\n").split("\n").each do |element|
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

  def self.secretary_name(card)
    @secretary_name = card["custom_info"]["Secretaría"]
    return if @secretary_name.nil?

    @secretary_name = @secretary_name.titleize
    convert_da if @secretary_name.include? ("Departamento Administrativo")
    convert_dapard if @secretary_name.include? ("Dapard")
    card["custom_info"]["Secretaría"] = @secretary_name
  end

  private

  def self.convert_da
    @secretary_name = @secretary_name.gsub("Departamento Administrativo", "D.A.")
    @secretary_name
  end

  def self.convert_dapard
    @secretary_name = @secretary_name.gsub("Dapard", "DAPARD")
    @secretary_name
  end
end
