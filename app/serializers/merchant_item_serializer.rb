class MerchantItemSerializer
  def self.index(merchant_id)
    merchant = Merchant.find(merchant_id)
    items = merchant.items

    {"data":
      items.map do |item|
        {"id": item.id.to_s,
        "type": "merchant",
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
