require 'spec_helper'

describe Cart do
  it {
    should have_many :items
    should belong_to :user
  }
  
  describe '#total' do
    it 'should return the total cost of items in the cart' do
      cart = create(:cart)
      5.times { cart.add(create(:product, price: 10)) }
      cart.total.should == 50
    end
  end
end
