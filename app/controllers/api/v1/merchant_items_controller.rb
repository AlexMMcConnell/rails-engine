class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    items = merchant.items
    render json: ItemSerializer.index(items)
  end
end
