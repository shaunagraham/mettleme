require 'spec_helper'

describe Authenticated::ProductsController do
  it {
    should be_kind_of AuthenticatedController
  }
  
  describe 'GET #index' do
    it 'should load all products for a user' do
      user  = create(:user, :seller)
      store = create(:store, user: user)
      
      5.times { create(:product, store: user.store) }
      
      sign_in(user) and get :index
      
      assigns(:products).should == user.store.products
      assigns(:products).count.should == 5
      
      response.should render_template 'authenticated/products/index'
    end
  end
  
  describe 'GET #new' do
    it 'should initialize a new product and render authenticated/products/edit' do
      user  = create(:user, paypal_id: '123')
      store = create(:store, user: user)

      sign_in(user) and get :new
      
      assigns(:product).should be_kind_of Product
      assigns(:product).store.should == @user.store
    end
    
    context 'without a store for the user' do
      it 'should redirect to authenticated/users#sell' do
        sign_in and get :new
        response.should redirect_to register_seller_user_path
      end
    end
  end
  
  describe 'POST #create with valid params' do
    it 'should create a new product for the current user and redirect to products#index' do
      user  = create(:user)
      store = create(:store, user: user)
      
      sign_in user
      
      product_params = attributes_for(:product, store_id: store.id)

      -> { 
        post :create, product: product_params
      }.should change(@user.store.products, :count).by(1)
      
      response.should redirect_to user_products_path
    end
  end
  
  describe 'DELETE #destroy with valid params' do
    it 'should destroy a product and redirect' do
      product = create(:product)
      sign_in(product.store.user) and delete :destroy, id: product.id
      Product.find_by_id(product.id).should be_nil
    end
  end
end
