require 'rails_helper'

describe Discount do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of(:percentage) }
    it { should validate_numericality_of(:percentage)}
    
    it { should validate_presence_of(:threshold) }
    it { should validate_numericality_of(:threshold)}
  end
end
