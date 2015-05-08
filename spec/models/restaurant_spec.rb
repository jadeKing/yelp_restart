require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'is not valid if the name has less than three characters' do
    restaurant = described_class.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'must have a unique name' do
    described_class.create(name: "Moes's Tavern")
    restaurant = described_class.new(name: "Moes's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end
end
