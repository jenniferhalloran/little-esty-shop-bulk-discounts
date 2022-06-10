require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_many(:discounts).through(:item) }
    it { should have_many(:merchants).through(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    describe 'applied discount' do
      xit "finds the best applicable discount for an invoice item" do
        merchant1 = Merchant.create!(name: "REI")
        merchant2 = Merchant.create!(name: "Target")

        item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)
        item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)
        item3 = merchant1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)
        customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
        customer2 = Customer.create!(first_name: "Sylvester", last_name: "Nader")

        invoice1 = customer1.invoices.create!(status: "in progress")
        invoice2 = customer2.invoices.create!(status: "completed")

        merchant1.discounts.create!(percentage: 10, threshold: 3) #discount 1
        merchant1.discounts.create!(percentage: 20, threshold: 6) #discount 2
        merchant2.discounts.create!(percentage: 30, threshold: 4) #discount 3

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 100, status: "packaged")#discount 1 applied
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 250, status: "pending") #no discount applied
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 9, unit_price: 80, status: "packaged") #discount 2 applied


        expect(invoice_item1.applied_discount). to eq(10)
        expect(invoice_item2.applied_discount). to eq(nil)
        expect(invoice_item3.applied_discount). to eq(20)

      end
    end
  end
end
