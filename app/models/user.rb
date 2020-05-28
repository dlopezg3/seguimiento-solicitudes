class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.fetch_trello_members
    board_id = "5ec56063edc3f53f0c17f299"
    url = "https://api.trello.com/1/boards/#{board_id}/members?key=#{ENV['TRELLO_KEY']}&token=#{ENV['TRELLO_TOKEN']}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
