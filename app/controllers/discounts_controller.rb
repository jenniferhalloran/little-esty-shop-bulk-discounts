class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new]

  def index
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end
end
