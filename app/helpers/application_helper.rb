module ApplicationHelper
  def active_filter(params)
    return "Secretarías" if params["secretaria"].nil?

    params["secretaria"]
  end

  def list_for_card(card)
    @lists.find {|key, value| key["id"] == card["idList"]}
  end
end
