class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.index
  end

  def show
    render json: MerchantSerializer.show(params[:id].to_i)
  end

  def find
    render json: MerchantSerializer.find(params[:name])
  end

  private

  def merch_params
    params.require(:merchant).permit(:name)
  end

end
