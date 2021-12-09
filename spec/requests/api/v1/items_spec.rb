require 'rails_helper'

describe "Items API" do
  it 'returns all items on index page' do
    item_list = create_list(:item, 4)

    get "/api/v1/items"

    result_items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(result_items.count).to eq(4)

    result_items.each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'returns specific item based on id' do
    item_list = create_list(:item, 4)
    item = item_list.first

    get "/api/v1/items/#{item.id}"

    result_item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(result_item[:id]).to eq(item.id.to_s)
    expect(result_item[:attributes][:name]).to eq(item.name)
    expect(result_item[:attributes][:description]).to eq(item.description)
    expect(result_item[:attributes][:unit_price]).to eq(item.unit_price)
    expect(result_item[:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can create a new item' do
    merchant = create(:merchant)
    item_params = {
      name: "Samsung",
      description: "Phone or something",
      unit_price: 400.00,
      merchant_id: merchant.id}
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate({item: item_params})

    item = Item.all.first

    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can update an item' do
    item = create(:item)
    item_params = { name: "Apple" }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Item.last.name).to eq(item.name)

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})

    expect(response).to be_successful

    expect(Item.last.name).to_not eq(item.name)
    expect(Item.last.name).to eq("Apple")
  end

  it 'can delete an item' do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    deleted_item_response = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(deleted_item_response[:id]).to eq(item.id.to_s)
    expect(Item.count).to eq(0)
  end

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

    result_items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to_not be_successful
  end
end
