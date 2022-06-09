require 'rails_helper'

describe 'Merchant Discount new page' do
  before do
    @rei = Merchant.create!(name: "REI")
    visit new_merchant_discount_path(@rei)
  end

  it 'allows the user to create a discount' do
    visit merchant_discounts_path(@rei)

    expect(page).to_not have_content("25% off 5 of the same item")

    click_link("Add New Bulk Discount")

    fill_in 'discount_percentage', with: 25
    fill_in 'discount_threshold', with: 5
    click_button("Create Discount")

    expect(current_path).to eq(merchant_discounts_path(@rei))
    expect(page).to have_content("25% off 5 of the same item")

  end
end
