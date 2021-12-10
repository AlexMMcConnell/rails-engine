class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_all(params)
    if params[:max_price].nil?
      params[:max_price] = Item.maximum("unit_price")
    end

    if params[:name].present?
      items = Item.where("lower(name) like ?", "%#{params[:name].downcase}%")
      .order(:name)
    else params[:min_price].present? || params[:max_price].present?
      items = Item.where("unit_price >= ?", params[:min_price].to_i)
                  .where("unit_price <= ?", params[:max_price].to_i) # this needs to be adjusted, 0
                  .order(:name)
    end
  end
end
