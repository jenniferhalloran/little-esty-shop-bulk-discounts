class Discount < ApplicationRecord
  validates_presence_of :percentage, :threshold
  validates_numericality_of :percentage, {greater_than_or_equal_to: 1, less_than_or_equal_to: 99}
  validates_numericality_of :threshold, greater_than_or_equal_to: 1

  belongs_to :merchant
  has_many :invoices, through: :merchant

end
