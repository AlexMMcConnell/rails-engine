class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: ItemSerializer.new(Item.find(item.id)), status: 201
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render status: 400
    end
  end

  def destroy
    item = ItemSerializer.new(Item.find(params[:id]))
    Item.destroy(params[:id])
    render json: item
  end

  def find
    if params[:name].present? && (params[:min_price].present? || params[:max_price].present?)
      render status: 400
    else
      render json: ItemSerializer.new(Item.find_all(params))
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
