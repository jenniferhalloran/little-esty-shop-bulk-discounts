class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :discounts, through: :item
  has_many :merchants, through: :item

  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum status: {'pending' => 0, 'shipped' => 1, 'packaged' => 2}

  def applied_discount
    discounts
    .where("discounts.threshold <= ?", quantity)
    .maximum("percentage")
  end

end
