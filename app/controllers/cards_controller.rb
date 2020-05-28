class CardsController < ApplicationController

  def index
    @members = User.fetch_trello_members
    @lists = List.fetch_trello_list
    @cards = Card.sort_by_date(Card.fetch_trello_cards)
  end
end
