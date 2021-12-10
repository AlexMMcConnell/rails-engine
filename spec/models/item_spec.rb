require 'rails_helper'

describe Item do
  it { should belong_to(:merchant) }

  it 'can find all items given a name parameter' do
    item1 = create(:item, name: "Barbecue Beef")
    item2 = create(:item, name: "Banana")

    params = {name: "ba"}
    expect(Item.find_all(params)).to eq([item2, item1])
  end

  it 'can find all items given price parameters' do
    item1 = create(:item, name: "Apple", unit_price: 50)
    item2 = create(:item, name: "Banana", unit_price: 30)
    item3 = create(:item, name: "Carrot", unit_price: 40)

    params = {min_price: 40}

    expect(Item.find_all(params)).to eq([item1, item3])
  end
end
