FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.decimal(l_digits: 2, r_digits: 3).to_f } #needs to be a float
    merchant
  end
end
