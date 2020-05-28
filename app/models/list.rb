class List < ApplicationRecord

  def self.fetch_trello_list
    board_id = "5ec56063edc3f53f0c17f299"
    url = "https://api.trello.com/1/boards/#{board_id}/lists?key=#{ENV['TRELLO_KEY']}&token=#{ENV['TRELLO_TOKEN']}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
