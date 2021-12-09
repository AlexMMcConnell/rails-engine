class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.index
  end

  def show
    render json: MerchantSerializer.find(params[:id])
  end

  private

  def merch_params
    params.require(:merchant).permit(:name)
  end
end
