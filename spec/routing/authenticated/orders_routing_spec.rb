require 'spec_helper'

describe 'routing to Authenticated::OrdersController' do
  it 'should route GET /user/orders to authenticated/orders#index' do
    {get: '/user/orders'}.should route_to('authenticated/orders#index')
  end
end