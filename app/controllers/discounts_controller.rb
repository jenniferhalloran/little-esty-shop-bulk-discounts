class DiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_discount, only: [:show, :edit, :update]

  def index
    @parsed_holidays = HolidayFacade.create_holiday
  end

  def show
  end

  def new
    @discount = Discount.new
  end

  def create
    discount = @merchant.discounts.create(discount_params)

    if discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      redirect_to new_merchant_discount_path(@merchant)
      flash[:alert] = "Please enter a valid discount between 1 - 99%"
    end
  end

  def destroy
    discount = Discount.find_by(merchant_id: params[:merchant_id], id: params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  def edit

  end

  def update
    @discount.update(discount_params)
    redirect_to merchant_discount_path(@merchant, @discount)
  end


private
  def discount_params
    params.require(:discount).permit(:percentage, :threshold)
  end

end
