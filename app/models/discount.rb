class Discount < ApplicationRecord
  validates_presence_of :percentage, :threshold
  validates_numericality_of :percentage, :threshold

  belongs_to :merchant

end
