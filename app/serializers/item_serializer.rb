class ItemSerializer


  def self.find_all(params)
    if params[:max_price].nil?
      params[:max_price] = Item.maximum("unit_price")
    end

    if params[:name].present? && (params[:min_price].present? || params[:min_price].present?)
      # throw error
    elsif params[:name].present?
      items = Item.where("lower(name) like ?", "%#{params[:name].downcase}%")
      .order(:name)
    else params[:min_price].present? || params[:max_price].present?
      items = Item.where("unit_price >= ?", params[:min_price].to_i)
                  .where("unit_price <= ?", params[:max_price].to_i) # this needs to be adjusted, 0
                  .order(:name)
    end

    if items.nil?
      # return error
    else
      {"data":
        items.map do |item|
          {"id": item[:id].to_s,
          "type": "item",
          "attributes": {
            "name": item[:name],
            "description": item[:description],
            "unit_price": item[:unit_price],
            "merchant_id": item[:merchant_id]
            }
          }
        end
      }
    end
  end
end
