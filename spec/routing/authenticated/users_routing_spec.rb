require 'spec_helper'

describe 'routing to Authenticated::UsersController' do
  it 'should route GET /user/edit to authenticated/users#edit' do
    {:get => '/user/edit'}.should route_to(
      :controller => 'authenticated/users',
      :action     => 'edit'
    )
  end
  
  it 'should route PUT /user to authenticated/users#update' do
    {:put => '/user'}.should route_to(
      :controller => 'authenticated/users',
      :action     => 'update'
    )
  end
end