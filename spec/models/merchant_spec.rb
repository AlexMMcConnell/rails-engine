require 'rails_helper'

describe Merchant do
  it { should have_many(:items) }

  it 'can find the alphabetically first merchant given a name' do
    merchant1 = create(:merchant, name: "Barry")
    merchant2 = create(:merchant, name: "Baal")
    name_param = "ba"

    expect(Merchant.find_by_name(name_param)).to eq(merchant2)
  end
end
