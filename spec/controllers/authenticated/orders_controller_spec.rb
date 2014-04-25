require 'spec_helper'

describe Authenticated::OrdersController do
  it {
    should be_kind_of AuthenticatedController
  }

  describe 'GET #index' do
    it 'should load all orders placed by the user and render' do
      user  = create(:user)
      order = create(:order, user: user)
      other_order = create(:order)
      
      sign_in(user) and get :index
      
      assigns(:orders).should == [order]
      response.should render_template 'authenticated/orders/index'
    end
  end
end