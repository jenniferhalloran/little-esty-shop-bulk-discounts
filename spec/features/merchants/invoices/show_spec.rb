require 'rails_helper'

RSpec.describe "Merchant Invoices Show Page" do
  before do
    @merchant1 = Merchant.create!(name: "REI")
    @merchant2 = Merchant.create!(name: "Target")

    @item1 = @merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)
    @item2 = @merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)
    @item3 = @merchant1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)
    @item4 = @merchant2.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15)
    # @item4 = @merchant1.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15)
    # @item5 = @merchant2.items.create!(name: "Nalgene", description: "Put all your cool stickers here", unit_price: 12)
    # @item6 = @merchant2.items.create!(name: "Fanny Pack", description: "Forget what the haters say, they're stylish", unit_price: 25)
    # @item7 = @merchant2.items.create!(name: "Mountain Bike", description: "Shred the gnar!!", unit_price: 1199)

    @customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
    @customer2 = Customer.create!(first_name: "Sylvester", last_name: "Nader")

    @invoice1 = @customer1.invoices.create!(status: "in progress")
    @invoice2 = @customer2.invoices.create!(status: "completed")

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 100, status: "packaged")
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 250, status: "pending")
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 9, unit_price: 80, status: "packaged")
    @invoice_item4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice1.id, quantity: 9, unit_price: 80, status: "packaged")

    visit merchant_invoice_path(@merchant1, @invoice1)
  end

  xit "displays the discounted revenue of items sold on the invoice", :vcr do
    @merchant1.discounts.create!(percentage: 10, threshold: 2)
    @merchant1.discounts.create!(percentage: 20, threshold: 6)
    @merchant2.discounts.create!(percentage: 30, threshold: 4)

    expect(page).to have_content("Discounted Revenue: $1,026.00")

  end

  it "displays the merchant's total revenue of items sold on the invoice", :vcr do
    expect(page).to have_content("REI's Total Revenue: $1,220.00")
    expect(page).to_not have_content("REI's Total Revenue: $1,940.00")
  end

  it "displays an invoice's attributes", :vcr do

    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Status: In Progress")
    expect(page).to have_content("Created at: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to_not have_content("Invoice ##{@invoice2.id}")
    expect(page).to_not have_content("Status: completed")

    within ".customer" do
      expect(page).to have_content("Customer Name: Leanne Braun")
      expect(page).to_not have_content("Sylvester Nader")
    end
  end

  it "displays a list of items on the invoice and their attributes", :vcr do

    expect(page).to have_content("Invoice Items")

    within ".invoice_items" do
      expect(page).to have_content("Item Name: Boots")
      expect(page).to have_content("Quantity Sold: 5")
      expect(page).to have_content("Sold at: $100.00")
      expect(page).to have_content("Invoice Item Status: Packaged")

      expect(page).to have_content("Item Name: Backpack")
      expect(page).to have_content("Quantity Sold: 9")
      expect(page).to have_content("Sold at: $80.00")

      expect(page).to_not have_content("Item Name: Tent")
      expect(page).to_not have_content("Quantity Sold: 3")
      expect(page).to_not have_content("Sold at: $250")
    end
  end


  it "can update and Invoice Item's status via a selector", :vcr do

    within "##{@invoice_item1.id}" do
      select "#{@invoice_item1.status}"
      select "shipped"
      expect(page).to have_button("Update Invoice Item Status")

      click_button "Update Invoice Item Status"
      expect(page).to have_select(selected: "shipped")
      expect(page).to_not have_select(selected: "packaged")
      expect(page).to_not have_select(selected: "pending")
    end

    expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))
  end
end
