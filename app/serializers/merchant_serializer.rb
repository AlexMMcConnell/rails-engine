class MerchantSerializer
  def self.index
    merchants = Merchant.all

    {"data":
      merchants.map do |merchant|
        {"id": merchant[:id].to_s,
        "type": "merchant",
        "attributes": {
          "name": merchant[:name]
          }
        }
      end
    }
  end

  def self.show(merchant_id)
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

  def self.find(merchant_name)
    merchant = Merchant.where("lower(name) like ?", "%#{merchant_name.downcase}%")
    .order(:name).first
    if merchant.present?
      {
        "data": {
        "id": merchant.id.to_s,
        "type": "merchant",
        "attributes": {
          "name": merchant[:name]
          }
        }
      }
    else
      {
        "data": {
        }
      }
    end
  end
end
