class CardsController < ApplicationController

  def index
    @cards = Card.sort_by_date(Card.fetch_trello_cards)
  end
end
