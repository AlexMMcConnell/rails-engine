class MerchantSerializer
  def self.index
    merchants = Merchant.all

    {"data": merchants.map do |merchant|
      {"id": merchant[:id].to_s,
      "type": "merchant",
      "attributes": {
        "name": merchant[:name]
        }
      }
    end
    }
  end

  def self.find(merchant_id)
    merchant = Merchant.find(merchant_id)
    {
      "data": {
      "id": merchant.id.to_s,
      "type": "merchant",
      "attributes": {
        "name": merchant[:name]
        }
      }
    }
  end
end
