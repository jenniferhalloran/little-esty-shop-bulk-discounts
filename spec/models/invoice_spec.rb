require 'rails_helper'

describe Invoice do
  before do
    @merchant1 = Merchant.create!(name: "REI")
    @merchant2 = Merchant.create!(name: "Target")

    @item1 = @merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)
    @item2 = @merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)
    @item3 = @merchant1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)
    @item4 = @merchant2.items.create!(name: "Socks", description: "Oooooh, wool", unit_price: 15)

    @customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
    @customer2 = Customer.create!(first_name: "Sylvester", last_name: "Nader")

    @invoice1 = @customer1.invoices.create!(status: "in progress", created_at: '2012-03-22 14:53:59')
    @invoice2 = @customer2.invoices.create!(status: "completed", created_at: '2012-03-21 14:53:59')

    @merchant1.discounts.create!(percentage: 10, threshold: 2)
    @merchant1.discounts.create!(percentage: 20, threshold: 6)
    @merchant2.discounts.create!(percentage: 30, threshold: 4)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 100, status: "packaged") #10% off
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 250, status: "pending")
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 9, unit_price: 80, status: "packaged") #20% off
    @invoice_item4 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice1.id, quantity: 6, unit_price: 16, status: "packaged") #30% off

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
        expect(@invoice1.total_revenue).to eq(1316)
        expect(@invoice2.total_revenue).to eq(750)
      end
    end

    describe "#merchants_revenue(id)" do
      it "returns the revenue for a specific merchant on an invoice" do
        expect(@invoice1.merchants_revenue(@merchant1.id)).to eq(1220)
        expect(@invoice1.merchants_revenue(@merchant2.id)).to eq(96)
        expect((@invoice1.merchants_revenue(@merchant1.id) + @invoice1.merchants_revenue(@merchant2.id))).to eq(@invoice1.total_revenue)
      end
    end

    describe 'total_discount_provided' do
      it 'the returns the discount that is provided by all merchants on an invoice' do

        expect(@invoice1.total_discount_provided).to eq(222.8)
      end
    end

    describe 'merchants_discount_provided(id)' do
      it 'the returns the discount that is provided by a specific merchant on an invoice' do

        expect(@invoice1.merchants_discount_provided(@merchant1.id)).to eq(194)
        expect(@invoice1.merchants_discount_provided(@merchant2.id)).to eq(28.8)
      end
    end

    describe 'total_discounted_revenue' do
      it 'returns the revenue of all merchants after discounts are applied' do

        expect(@invoice1.total_discounted_revenue).to eq(1093.2)
      end
    end

    describe 'merchants_discounted_revenue(id)' do
      it 'returns the revenue of a specific merchant after discounts are applied' do

        expect(@invoice1.merchants_discounted_revenue(@merchant1.id)).to eq(1026)
        expect(@invoice1.merchants_discounted_revenue(@merchant2.id)).to eq(67.2)
      end
    end
  end
end
