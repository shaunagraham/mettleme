require 'spec_helper'

describe Authenticated::StoresController do
  it {
    should be_kind_of AuthenticatedController
  }
  
  describe 'GET #edit' do
    context 'when user is a registered seller' do
      it 'should should load or initialize a new store for the user and render stores/new' do
        user = create(:user, :seller)
        sign_in(user) and get :edit
        assigns(:store).user.should == user
        response.should render_template 'authenticated/stores/edit'
      end
    end
    
    context 'when user is not a registered seller' do
      it 'should redirect to /user/sell' do
        sign_in and get :edit
        response.should redirect_to register_seller_user_path
      end
    end
  end
  
  describe 'POST #create' do
    context 'with valid params' do
      it 'should create a product and redirect to ...' do
        user  = create(:user)
        attrs = attributes_for(:store, user_id: user.id)
        
        user.store.should be_nil
        
        sign_in(user) and post :create, store: attrs
        
        user.reload.store.should be_present
        user.store.should be_persisted
        
        response.should redirect_to edit_user_store_path
      end
    end
  end
  
  describe 'DELETE #destroy' do
    it 'should destroy a store and redirect to user/edit' do
      user  = create(:user)
      store = create(:store, user: user)
      
      sign_in(user) and delete :destroy
      
      user.reload.store.should be_nil
      response.should redirect_to edit_user_path
    end
  end
end
