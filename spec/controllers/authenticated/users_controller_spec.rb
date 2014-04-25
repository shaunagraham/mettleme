require 'spec_helper'

describe Authenticated::UsersController do
  it {
    should be_kind_of AuthenticatedController
  }
  
  describe 'GET #sell' do
    context 'if the user is registered as a seller' do
      it 'should redirect to store/edit' do
        user = create(:user, paypal_id: '123')
        user.should be_seller
        
        sign_in(user) and get :sell
        response.should redirect_to edit_user_store_path
      end
    end
    
    context 'if the user is not registered as a seller' do
      it 'should render users/sell' do
        sign_in and get :sell

        assigns(:user).should == @user
        response.should render_template 'authenticated/users/sell'
      end
    end
  end
  
  describe 'GET #edit' do
    it 'should load a user and render authenticated/users/edit' do
      sign_in and get :edit
      
      assigns(:user).should == @user
      response.should render_template 'authenticated/users/edit'
    end
  end
  
  describe 'PUT #update' do
    context 'when successful' do
      it 'updates a user and redirects to users/edit' do
        sign_in and put :update, :user => {
          :email  => 'newemail@example.com'
        }

        assigns(:user).should == @user
        assigns(:user).email.should == 'newemail@example.com'
        flash[:notice].should == 'Profile updated'
        response.should redirect_to edit_user_path
      end      
    end
    
    context 'when unsuccessful' do
      it 'does not update a user, and renders users/edit' do
        sign_in and put :update, :user => {:email => nil}

        @user.email.should_not be_nil
        @user.should have(1).error_on(:email)

        flash[:notice].should be_nil
        response.should render_template 'users/edit'
      end
    end
  end  
end
