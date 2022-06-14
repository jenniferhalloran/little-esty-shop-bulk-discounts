require 'rails_helper'

RSpec.describe HolidayService do
  it "accesses the holidays API endopoint", :vcr do
    service = HolidayService.get_holidays

    expect(service).to be_a(Array)
    expect(service).to_not be_empty
  end
end
