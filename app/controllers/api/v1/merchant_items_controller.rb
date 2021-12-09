class Api::V1::MerchantItemsController < ApplicationController
  def index
    render json: MerchantItemSerializer.index(params[:merchant_id])
  end
end
