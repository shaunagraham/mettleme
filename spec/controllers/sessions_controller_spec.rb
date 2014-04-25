require 'spec_helper'

describe SessionsController do
  it 'should redirect to root_path after login' do
    user = create(:user)
    post :create, :session => {:email => user.email, :password => user.password}
    response.should redirect_to edit_user_path
  end
end
