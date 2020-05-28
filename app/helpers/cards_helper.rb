module CardsHelper
  def convert_utc_date_to_local(string_date)
    date = string_date.to_datetime.in_time_zone("Bogota").to_date
  end

  def status_color(card_list)

  end
end
