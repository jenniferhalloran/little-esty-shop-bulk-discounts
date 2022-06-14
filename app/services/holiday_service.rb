class HolidayService

  def self.get_holidays
    connection = Faraday.new(url: "https://date.nager.at")
    holidays = connection.get("/api/v3/NextPublicHolidays/us")
    JSON.parse(holidays.body, symbolize_names: true)
  end

end
