class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create, :destroy]

  def index
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end

  def create
    @merchant.discounts.create!(discount_params)
    redirect_to merchant_discounts_path(@merchant)
  end

  def destroy
    discount = Discount.find_by(merchant_id: params[:merchant_id], id: params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end


private

def discount_params
  params.require(:discount).permit(:percentage, :threshold)

end
end
