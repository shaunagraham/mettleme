require 'spec_helper'

describe Product do
  it {
    should belong_to :store
    should have_and_belong_to_many :categories
    should validate_presence_of :store
    should validate_presence_of :name
    should validate_presence_of :gender
    should validate_presence_of :description
    should validate_presence_of :price
    should validate_presence_of :number_in_stock
    should validate_presence_of :days_to_ship
    should act_as_taggable_on :materials
    should act_as_taggable_on :colors
    should act_as_taggable_on :styles # and should limit styles to maximum of three
    
    # todo:
    # should be tagged with 'sizes_available'
    # should allow multiple product images    
  }
  
  it 'should create a URL slug before save' do
    build(:product, name: 'My Product').tap do |product|
      product.slug.should be_nil
      product.save!
      product.slug.should == 'my-product'
      product.update_attribute(:name, "John's Great Product!")
      product.slug.should == 'johns-great-product'
    end
  end  
end
