require 'rails_helper'

describe "Items API" do
  it 'can find all items based on name' do
    item1 = create(:item, name: "Product")
    item2 = create(:item, name: "Duct Tape")

    get "/api/v1/items/find_all?name=uct"

    result_items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(result_items.first[:id]).to eq(item2.id.to_s)
    expect(result_items.last[:id]).to eq(item1.id.to_s)
  end

  it 'can find all items based on a min/max price query' do
    item1 = create(:item, name: "Samsung", unit_price: 30)
    item2 = create(:item, name: "Apple", unit_price: 50)
    item3 = create(:item, name: "Android", unit_price: 40)

    get "/api/v1/items/find_all?min_price=40"

    result_items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(result_items.first[:id]).to eq(item3.id.to_s)
    expect(result_items.last[:id]).to eq(item2.id.to_s)
  end

  xit 'doesnt search for items if both a name and min/max price query are present' do
    item1 = create(:item, name: "Product")
    item2 = create(:item, name: "Duct Tape")

    get "/api/v1/items/find_all?name=uct&min_price=2"

    binding.pry
    result_items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to_not be_successful
  end
end
