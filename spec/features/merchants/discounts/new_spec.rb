require 'rails_helper'

describe 'Merchant Discount new page' do
  before do
    @rei = Merchant.create!(name: "REI")
  end

  it 'allows the user to create a discount', :vcr do
    visit merchant_discounts_path(@rei)

    expect(page).to_not have_content("25% off 5 of the same item")

    click_link("Add New Bulk Discount")

    fill_in 'discount_percentage', with: 25
    fill_in 'discount_threshold', with: 5
    click_button("Create Discount")

    expect(current_path).to eq(merchant_discounts_path(@rei))
    expect(page).to have_content("25% off 5 of the same item")
  end

  it "displays an error message if user tried to make a discount under 1% or over 99%" do
    visit new_merchant_discount_path(@rei)

    fill_in 'discount_percentage', with: 100
    fill_in 'discount_threshold', with: 5
    click_button("Create Discount")

    expect(current_path).to eq(new_merchant_discount_path(@rei))
    expect(page).to have_content("Please enter a valid discount between 1 - 99%")

  end
end
