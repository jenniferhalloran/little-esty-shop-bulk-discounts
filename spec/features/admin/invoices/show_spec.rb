require 'rails_helper'

describe "Admin Invoice Show Page" do
  before do
    @merchant1 = Merchant.create!(name: "REI")
    @merchant2 = Merchant.create!(name: "Target")

    @item1 = @merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)
    @item2 = @merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)
    @item3 = @merchant1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)
    @item4 = @merchant2.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15)
    @item5 = @merchant1.items.create!(name: "Fanny Pack", description: "Forget what the haters say, they're stylish", unit_price: 25)

    @customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
    @customer2 = Customer.create!(first_name: "Sylvester", last_name: "Nader")

    @invoice1 = @customer1.invoices.create!(status: "in progress", created_at: '2012-03-21 14:53:59')
    @invoice2 = @customer2.invoices.create!(status: "completed", created_at: '2012-03-22 14:53:59')

    @merchant1.discounts.create!(percentage: 10, threshold: 2)
    @merchant1.discounts.create!(percentage: 20, threshold: 6)
    @merchant2.discounts.create!(percentage: 30, threshold: 4)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 100, status: "packaged") #10% off
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 250, status: "pending")
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 9, unit_price: 80, status: "packaged") #20% off
    @invoice_item4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice1.id, quantity: 6, unit_price: 16, status: "packaged") #30% off
    @invoice_item5 = InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 16, status: "packaged")

    visit admin_invoice_path(@invoice1)
  end

  it "displays invoice details", :vcr do

    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Status: In Progress")
    expect(page).to have_content("Created at: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to_not have_content("Invoice ##{@invoice2.id}")
    expect(page).to_not have_content("Status: Completed")

    within ".customer" do
      expect(page).to have_content("Customer Name: Leanne Braun")
      expect(page).to_not have_content("Sylvester Nader")
    end
  end

  it "displays the invoice items and information" do
    within ".invoice_items" do
      within "##{@invoice_item1.id}" do
        expect(page).to have_content("Item Name: Boots")
        expect(page).to have_content("Quantity Sold: 5")
        expect(page).to have_content("Sold at: $100.00")
        expect(page).to have_content("Invoice Item Status: Packaged")
      end

      expect(page).to have_content("Item Name: Backpack")
      expect(page).to have_content("Item Name: Socks")
      expect(page).to have_content("Item Name: Fanny Pack")
    end
  end

  it "displays the total revenue of all items", :vcr do

    expect(page).to have_content("Total Revenue: $1,332.00")
  end

  it "displays the total discounted revenue of all items", :vcr do

    expect(page).to have_content("Discounted Revenue: $1,109.20")
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

    expect(current_path).to eq(admin_invoice_path(@invoice1))
  end
end
