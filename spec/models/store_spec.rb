require 'spec_helper'

describe Store do
  it {
    should belong_to :user
    should belong_to :country
    should belong_to :state
    should have_many :products
    should validate_presence_of :name
    should validate_uniqueness_of :name
    should validate_presence_of :owner_name
    should validate_presence_of :country
    should validate_presence_of :state
    should validate_presence_of :city
    should validate_presence_of :description
    should act_as_taggable_on :tags
    should have_attached_file :image
  }
  
  it 'should create a URL slug before save' do
    build(:store, name: 'My New Store').tap do |store|
      store.slug.should be_nil
      store.save!
      store.slug.should == 'my-new-store'
      store.update_attribute(:name, "John's Great Store!")
      store.slug.should == 'johns-great-store'
    end
  end
end
