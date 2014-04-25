require 'spec_helper'

describe User do
  it {
    should have_one :store
    should have_many :favourites
    should have_many :orders
    should have_many :products
    should have_many :sent_messages
    should have_and_belong_to_many :received_messages
    should validate_presence_of :email
    should validate_presence_of :first_name
    should validate_presence_of :last_name        
  }
  
  describe '#name' do
    it 'should return "#{first_name} #{last_name}"' do
      build(:user).tap do |user|
        user.name.should == "#{user.first_name} #{user.last_name}"
      end
    end
  end
  
  describe '#seller' do
    it 'should return true if the user has a paypal_id' do
      create(:user, paypal_id: '123').tap do |user|
        user.should be_seller
        user.update_attribute(:paypal_id, nil)
        user.should_not be_seller
      end
    end
    
    it 'should return false if the user does not have a paypal_id' do
      build(:user, paypal_id: nil).should be_valid
      
      create(:user, paypal_id: nil).tap do |user|
        user.should_not be_seller        
        user.update_attribute(:paypal_id, '123')
        user.should be_seller
      end
    end
  end
end