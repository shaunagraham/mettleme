require 'spec_helper'

describe 'routing to Authenticated::ProductsController' do
  it 'should route POST /user/products to authenticated/products#create' do
    {:post => '/user/products'}.should route_to(
      :controller => 'authenticated/products',
      :action     => 'create'
    )
  end
  
  it 'should route DELETE /user/products/:id to authenticated/products#destroy' do
    {delete: '/user/products/1'}.should route_to('authenticated/products#destroy', id: '1')
  end
end