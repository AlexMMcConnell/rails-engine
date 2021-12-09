class Api::V1::ItemMerchantsController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    merchant = item.merchant
    render json: MerchantSerializer.show(merchant.id)
  end
end
