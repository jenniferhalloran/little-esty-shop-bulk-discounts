require 'rails_helper'

RSpec.describe Holiday do
  describe 'it has attributes' do
    it 'exists and has readable attributes', :vcr do
      holiday = Holiday.new({name: "Jenn's Birthdate", date: "1993-05-19"})

      expect(holiday.name).to eq("Jenn's Birthdate")
      expect(holiday.date).to eq("1993-05-19")
    end
  end
end
