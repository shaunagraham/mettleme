require 'spec_helper'

describe 'routing to CartController' do
  it 'should route GET /cart to cart#show' do
    {get: '/cart'}.should route_to(
      controller: 'cart',
      action: 'show'
    )
  end
  
  it 'routes PUT /cart/add/1 to cart#add' do
    {:put => '/cart/add/1'}.should route_to(
      :controller => 'cart',
      :action     => 'add',
      :id         => '1'
    )
  end
  
  it 'should route DELETE /cart/remove/1 to cart#remove' do
    {delete: '/cart/remove/1'}.should route_to(
      controller: 'cart',
      action: 'remove',
      id: '1'
    )
  end
  
  it 'should route GET /cart/checkout to cart#checkout' do
    {get: '/cart/checkout'}.should route_to(
      controller: 'cart',
      action: 'checkout'
    )
  end
end