require 'spec_helper'

describe Review, type: :model do
  # before do
  #   let!(:kfc) { Restaurant.create name: 'KFC' }
  #   described_class.create thoughts: 'Its chicken'
  # end

  it { should belong_to(:restaurant) }

  it 'is invalid if rating is more than 5' do
    review = described_class.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
  # it 'gets deleted if restaurant is deleted' do
  #   subject.should_belong_to(:restaurant)
  #   :kfc.destroy
  # end
end
