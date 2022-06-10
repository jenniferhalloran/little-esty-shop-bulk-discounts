require 'rails_helper'

describe Invoice do
  before do
    @merchant1 = Merchant.create!(name: "REI")
    @merchant2 = Merchant.create!(name: "Target")

    @item1 = @merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)
    @item2 = @merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)
    @item3 = @merchant2.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)
    # @item4 = @merchant1.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15)
    # @item5 = @merchant2.items.create!(name: "Nalgene", description: "Put all your cool stickers here", unit_price: 12)
    # @item6 = @merchant2.items.create!(name: "Fanny Pack", description: "Forget what the haters say, they're stylish", unit_price: 25)
    # @item7 = @merchant2.items.create!(name: "Mountain Bike", description: "Shred the gnar!!", unit_price: 1199)

    @customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
    @customer2 = Customer.create!(first_name: "Sylvester", last_name: "Nader")

    @invoice1 = @customer1.invoices.create!(status: "in progress", created_at: '2012-03-22 14:53:59')
    @invoice2 = @customer2.invoices.create!(status: "completed", created_at: '2012-03-21 14:53:59')
    @invoice3 = @customer2.invoices.create!(status: "in progress", created_at: '2012-03-23 14:53:59')

    @merchant1.discounts.create!(percentage: 10, threshold: 3) #discount 1
    @merchant1.discounts.create!(percentage: 20, threshold: 6) #discount 2
    @merchant2.discounts.create!(percentage: 30, threshold: 4) #discount 3

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 100, status: "packaged") #discount 2 should apply
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 250, status: "pending") #discount 1 should apply
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 9, unit_price: 80, status: "shipped") #discount 3 should apply
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe "class methods" do

    describe ".invoices_with_merchant_items(merchant)" do
      it "returns invoices that have include at least one of the merchant's items" do
        expect(Invoice.invoices_with_merchant_items(@merchant1)).to include(@invoice1)
        expect(Invoice.invoices_with_merchant_items(@merchant1)).to include(@invoice2)
        expect(Invoice.invoices_with_merchant_items(@merchant1)).to_not include(@invoice3)
      end
    end

    describe '.incomplete_invoices' do
      it 'returns the invoices with items that have not yet been shipped, ordered from oldest to newest' do
        expect(Invoice.incomplete_invoices).to eq([@invoice2, @invoice1])
      end
    end
  end

  describe "instance methods" do
    it "#invoice_customer" do
      expect(@invoice1.invoice_customer).to eq("Leanne Braun")
    end

    describe "#total_revenue" do
      it "returns the revenue for all merchants on an invoice" do
        expect(@invoice1.total_revenue).to eq(1220)
        expect(@invoice2.total_revenue).to eq(750)
      end
    end

    describe "#merchants_revenue(merchant)" do
      it "returns the revenue for a specific merchant on an invoice" do
        expect(@invoice1.merchants_revenue(@merchant1)).to eq(500)
        expect(@invoice1.merchants_revenue(@merchant2)).to eq(720)
        expect((@invoice1.merchants_revenue(@merchant1) + @invoice1.merchants_revenue(@merchant2))).to eq(@invoice1.total_revenue)
      end
    end

    describe 'discounted_revenue' do
      xit 'returns the revenue from an invoice after discounts are applied' do

        expect(@invoice1.discounted_revenue).to eq()
      end
    end
  end
end
