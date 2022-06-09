require 'rails_helper'

describe 'Merchant Discount Edit Page' do
  before do
    @rei = Merchant.create!(name: "REI")

    @discount_1 = @rei.discounts.create!(percentage: 20, threshold: 2)
    @discount_2 = @rei.discounts.create!(percentage: 35, threshold: 3)
  end

  it 'allows the user to edit a discount' do
    visit merchant_discount_path(@rei, @discount_1)
    expect(page).to have_content("Quantity Threshold: 2 items")
    expect(page).to have_content("Percentage Discount: 20%")

    expect(page).to_not have_content("Quantity Threshold: 3 items")
    expect(page).to_not have_content("Percentage Discount: 35%")

    click_link("Edit This Bulk Discount")

    fill_in 'discount_percentage', with: 15
    fill_in 'discount_threshold', with: 5
    click_button("Update Discount")

    expect(current_path).to eq(merchant_discount_path(@rei, @discount_1))
    expect(page).to have_content("Quantity Threshold: 5 items")
    expect(page).to have_content("Percentage Discount: 15%")

    expect(page).to_not have_content("Quantity Threshold: 2 items")
    expect(page).to_not have_content("Percentage Discount: 20%")

  end
end
