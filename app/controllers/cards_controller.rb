class CardsController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_filtered_cards

  def index
    @members = User.fetch_trello_members
    @lists = List.fetch_trello_list
  end

  private

  def set_filtered_cards
    @cards = Card.sort_by_date(Card.fetch_trello_cards)
    return @cards if params.empty?

    @cards = Card.secretary_filter(@cards, params.slice(:secretaria)) unless params["secretaria"].nil?
  end
end
