class Discount < ApplicationRecord
  validates_presence_of :percentage, :quantity
  validates_numericality_of :percentage, :quantity
  
  belongs_to :merchant

end
