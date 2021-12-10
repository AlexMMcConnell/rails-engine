require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchants.count).to eq(4)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id.to_s)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it "can get all items that belong to a merchant" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item_list_1 = create_list(:item, 3, merchant: merchant1)
    item_list_2 = create_list(:item, 1, merchant: merchant2)

    get "/api/v1/merchants/#{merchant1.id}/items"

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to eq(merchant1.id)
    end
  end

  it 'can find merchants by name' do
    merchant1 = create(:merchant, name: "Banner")
    merchant2 = create(:merchant, name: "Baal")

    get "/api/v1/merchants/find?name=ba"

    result_merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(result_merchant[:id]).to eq(merchant2.id.to_s)
    expect(result_merchant[:attributes][:name]).to eq(merchant2.name)
  end
end
