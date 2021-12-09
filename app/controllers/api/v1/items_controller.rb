class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.index
  end

  def find
    render json: ItemSerializer.find_all(params)
  end
end
