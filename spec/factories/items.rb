FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.number(digits: 2) } #needs to be a float
    merchant
  end
end
