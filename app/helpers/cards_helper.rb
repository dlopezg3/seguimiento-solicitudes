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
    card_members = board_members.select { |member, value|  board_members.include? (member) }
    return "" if card_members.empty?

    card_members.map{|member| member["fullName"]}.reduce("")
  end
end
