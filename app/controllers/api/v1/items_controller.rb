class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.index(Item.all)
  end

  def show
    render json: ItemSerializer.show(params[:id])
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: ItemSerializer.show(item.id), status: 201
    end
  end

  def update
    item = Item.find(params[:id])
    if item_params["merchant_id"].nil?
      merchant_id = item.merchant_id
    else
      merchant_id = item_params["merchant_id"].to_i
    end

    if Merchant.find(merchant_id).present?
      item.update(item_params)
      render json: ItemSerializer.show(params[:id])
    else
      render status: 400
    end
  end

  def destroy
    item = ItemSerializer.show(params[:id])
    Item.destroy(params[:id])
    render json: item
  end

  def find
    if params[:name].present? && (params[:min_price].present? || params[:max_price].present?)
      render status: 400
    else
      render json: ItemSerializer.find_all(params)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
