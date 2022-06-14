class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  validates :status, presence: true

  enum status: {'cancelled' => 0, 'in progress' => 1, 'completed' => 2}


  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end

  def total_discount_provided
    invoice_items
    .joins(:discounts)##this line joins the invoice items with the corresponding merchant's discounts only, due to the relationships??
    .where("discounts.threshold <= invoice_items.quantity")
    .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity *(discounts.percentage)/100.00) AS highest_discount')
    .group(:id)
    .sum(&:highest_discount)
  end

  def total_discounted_revenue
    total_revenue - total_discount_provided
  end

  def merchants_revenue(id)
    invoice_items.joins(:merchants)
    .where("items.merchant_id = ?", id)
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def merchants_discount_provided(id)
    invoice_items
    .joins(:discounts)
    .where("discounts.threshold <= invoice_items.quantity")
    .where("items.merchant_id = ?", id)
    .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity *(discounts.percentage)/100.00) AS highest_discount')
    .group(:id)
    .sum(&:highest_discount)
  end

  def merchants_discounted_revenue(id)
    merchants_revenue(id) - merchants_discount_provided(id)
  end

  def invoice_customer
    "#{customer.first_name} #{customer.last_name}"
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(invoice_items: {status: 1})
    .distinct
    .order(:created_at)
  end

  def self.invoices_with_merchant_items(merchant)
    merchant.invoices.distinct(:id)
  end
end
