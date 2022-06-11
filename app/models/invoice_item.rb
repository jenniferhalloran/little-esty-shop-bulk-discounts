class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :discounts, through: :item
  has_many :merchants, through: :item

  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum status: {'pending' => 0, 'shipped' => 1, 'packaged' => 2}

  def percentage_applied
    applied_discount.percentage
  end

  def applied_discount
    discounts
    .where("discounts.threshold <= ?", quantity)
    .order("percentage")
    .first
  end

  def has_discount?
    applied_discount != nil
  end

end
