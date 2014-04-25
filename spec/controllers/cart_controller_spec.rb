require 'spec_helper'

describe CartController do
  describe 'GET #show without an existing cart' do
    it 'should set up a cart and render cart/show' do
      -> { get :show }.should change(Cart, :count).by(1)
      response.should render_template 'cart/show'
    end
  end
    
  describe 'GET #show with an existing cart' do
    it 'should load the cart and render cart/show' do
      cart = create(:cart, :anonymous)
      session[:cart_id] = cart.id
      
      -> { get :show }.should_not change(Cart, :count)
      
      assigns(:cart).should == cart
      response.should render_template 'cart/show'
    end
  end
  
  describe 'PUT #add' do
    it 'should add a product to a cart and redirect to cart_path' do
      product = create(:product)
      cart    = create(:cart)
      
      session[:cart_id] = cart
      
      -> { put :add, id: product.id }.should change(cart.items, :count).by(1)
      
      response.should redirect_to cart_path
    end
  end
  
  describe 'DELETE #remove' do
    it 'should remove a product from the cart and redirect to cart_path' do
      cart = create(:cart)
      item = create(:cart_item, cart: cart)
      
      session[:cart_id] = cart
      
      -> { delete :remove, id: item.id }.should change(cart.items, :count).by(-1)
      
      response.should redirect_to cart_path      
    end
  end
  
  describe 'GET #checkout' do
    it 'should temporarily create a new order and redirect' do
      user = create(:user)
      cart = create(:cart, user: user)
      
      3.times { cart.add(create(:product)) }
      session[:cart_id] = cart

      -> { sign_in(user) and get :checkout }.should change(user.orders, :count).by(1)
      
      response.should redirect_to payment_confirmation_path
    end
  end
end