require 'spec_helper'

describe Review, type: :model do
  # before do
  #   let!(:kfc) { Restaurant.create name: 'KFC' }
  #   described_class.create thoughts: 'Its chicken'
  # end

  it { should belong_to(:restaurant) }

  # it 'gets deleted if restaurant is deleted' do
  #   subject.should_belong_to(:restaurant)
  #   :kfc.destroy
  # end
end
