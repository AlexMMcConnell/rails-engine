class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    merchant = Merchant.find_by_name(params[:name])
    if merchant.present?
      render json: MerchantSerializer.new(Merchant.find_by_name(params[:name]))
    else
      render json: {"data":{}}, status: 400
    end
  end
end
