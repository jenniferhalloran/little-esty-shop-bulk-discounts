require 'rails_helper'

describe 'Merchant Bulk Discounts Index' do
  before do
    @rei = Merchant.create!(name: "REI")

    @discount_1 = @rei.discounts.create!(percentage: 20, threshold: 2)
    @discount_2 = @rei.discounts.create!(percentage: 35, threshold: 3)
    @discount_3 = @rei.discounts.create!(percentage: 50, threshold: 4)

    visit merchant_discounts_path(@rei)
  end

  it "lists all of the merchant's bulk discounts, including percentage discount and quantity thresholds", :vcr do
    
    expect(page).to have_content("20% off 2 of the same item")
    expect(page).to have_content("35% off 3 of the same item")
    expect(page).to have_content("50% off 4 of the same item")
  end


  it "links to the show page for each discount", :vcr do

    within "#discount-#{@discount_1.id}" do
      click_link("Details")

      expect(current_path).to eq(merchant_discount_path(@rei, @discount_1))
    end

    visit merchant_discounts_path(@rei)
    within "#discount-#{@discount_2.id}" do
      click_link("Details")

      expect(current_path).to eq(merchant_discount_path(@rei, @discount_2))
    end

    visit merchant_discounts_path(@rei)
    within "#discount-#{@discount_3.id}" do
      click_link("Details")

      expect(current_path).to eq(merchant_discount_path(@rei, @discount_3))
    end
  end

  it "links to a page to create a new discount", :vcr do
    click_link "Add New Bulk Discount"

    expect(current_path).to eq(new_merchant_discount_path(@rei))
    expect(page).to have_content("Create New Bulk Discount")
  end

  it "displays a link to delete each bulk discount", :vcr do

    expect(page).to have_content("20% off 2 of the same item")

    within "#discount-#{@discount_1.id}" do
      click_link("Delete")
    end

    expect(current_path).to eq(merchant_discounts_path(@rei))
    expect(page).to_not have_content("20% off 2 of the same item")
  end

  it "displays the next three upcoming US holidays", :vcr do

  end
end
