class HolidayFacade

  def self.create_holiday
    json = HolidayService.get_holidays

    json.first(3).map do |holiday_data|
      Holiday.new(holiday_data)
    end
  end

end
