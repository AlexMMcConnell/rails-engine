class Merchant < ApplicationRecord
  has_many :items

  def self.find_by_name(merchant_name)
    Merchant.where("lower(name) like ?", "%#{merchant_name.downcase}%")
            .order(:name)
            .first
  end
end
