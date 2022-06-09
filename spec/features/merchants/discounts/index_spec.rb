require 'rails_helper'

describe 'Merchant Bulk Discounts Index' do
  before do
    @rei = Merchant.create!(name: "REI")

    @discount_1 = @rei.discounts.create!(percentage: 35, threshold: 3)
    @discount_2 = @rei.discounts.create!(percentage: 20, threshold: 2)
    @discount_3 = @rei.discounts.create!(percentage: 50, threshold: 4)

    visit merchant_discounts_path(@rei)
  end

  it "lists all of the merchant's bulk discounts, including percentage discount and quantity thresholds" do

    expect(page).to have_content("20% off 2 of the the same item")
    expect(page).to have_content("35% off 3 of the the same item")
    expect(page).to have_content("50% off 4 of the the same item")
  end
end
