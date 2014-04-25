require 'spec_helper'

describe Authenticated::FavouritesController do
  it {
    should be_kind_of AuthenticatedController
  }

  before :each do
    @user    = create(:user)
    @product = create(:product)
    @store   = create(:store)
    
    sign_in @user    
  end

  describe 'GET #products' do
    it 'should load all favourited products for a user and render authenticated/favourites/products' do
      products = [create(:product), create(:product), create(:product)]
      products.each { |p| @user.create_favourite('product', p.id) }
      
      get :products
      
      assigns(:favourite_products).should == products
      response.should render_template 'authenticated/favourites/products'
    end
  end

  describe 'GET #stores' do
    it 'should load all favourited stores for a user and render authenticated/favourites/stores' do
      stores = [create(:store), create(:store), create(:store)]
      stores.each { |s| @user.create_favourite('store', s.id) }
      
      get :stores
      
      assigns(:favourite_stores).should == stores
      response.should render_template 'authenticated/favourites/stores'
    end
  end
  
  describe 'POST #create with params for a non-existing favourite product' do
    it 'should add a favourite product for the user' do
      -> { 
        post :create, favoured_type: 'product', favoured_id: @product.id 
      }.should change(@user.favourites, :count).by(1)
      
      @user.favourites.last.favoured.should == @product
      response.status.should == 200
      response.body.should be_blank
    end
  end
  
  describe 'POST #create with params for an existing favourite product' do
    it 'should not add another favourite' do
      @user.create_favourite('product', @product.id)
            
      -> { 
        post :create, favoured_type: 'product', favoured_id: @product.id 
      }.should_not change(@user.favourites, :count)
      
      response.status.should == 400 # bad request
      response.body.should be_blank
    end
  end  
  
  describe 'POST #create with params for a non-existing favourite store' do
    it 'should add a favourite store for the user' do
      -> { 
        post :create, favoured_type: 'store', favoured_id: @store.id 
      }.should change(@user.favourites, :count).by(1)
    
      @user.favourites.last.favoured.should == @store
      response.status.should == 200
      response.body.should be_blank    
    end
  end  
  
  describe 'POST #create with params for an existing favourite store' do
    it 'should not add another favourite' do
      @user.create_favourite('store', @store.id)
            
      -> { 
        post :create, favoured_type: 'store', favoured_id: @store.id 
      }.should_not change(@user.favourites, :count)
      
      response.status.should == 400 # bad request
      response.body.should be_blank
    end    
  end    
end
