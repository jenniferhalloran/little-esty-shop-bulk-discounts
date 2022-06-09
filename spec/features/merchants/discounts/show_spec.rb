require 'rails_helper'

describe 'Merchant Bulk Discount Show' do
  before do
    @rei = Merchant.create!(name: "REI")

    @discount_1 = @rei.discounts.create!(percentage: 20, threshold: 2)
    @discount_2 = @rei.discounts.create!(percentage: 35, threshold: 3)

    visit merchant_discount_path(@rei, @discount_1)
  end

  it "displays the bulk discount's quantity threshold and percentage discount" do
    
    expect(page).to have_content("Quantity Threshold: 2 items")
    expect(page).to_not have_content("Quantity Threshold: 3 items")

    expect(page).to have_content("Percentage Discount: 20%")
    expect(page).to_not have_content("Percentage Discount: 35%")
  end
end
