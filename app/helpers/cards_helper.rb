module CardsHelper

  def convert_utc_date_to_local(string_date)
    date = string_date.to_datetime.in_time_zone("Bogota").to_date
  end

  def list_for_card(lists, card)
    lists.find {|key, value| key["id"] == card["idList"]}
  end

  def status_color(list_name)
    return "#DF3B46" if list_name == "Nuevas solicitudes"
    return "#DF3B46" if list_name == "Recibida"
    return "#FACD3A" if list_name == "Revisada"
    return "#00A878" if list_name == "Accionada"
    return "#00A878"
  end

  def card_responsable(card, board_members)
    card_members = card["idMembers"]
    card_members_names = []

    card_members.each do |card_member|
      board_members.each do |board_member|
        card_members_names << board_member["fullName"] if board_member["id"] == card_member
      end
    end
    card_members_names.join("")
  end

  def active_filter(params)
    return "Secretarías" if params["secretaria"].nil?

    params["secretaria"]
  end

  def secretarias_array(cards)
    cards.reject { |card| card["custom_info"]["Secretaría"].nil?}
         .map!   { |card| card["custom_info"]["Secretaría"] }
         .uniq
  end
end
