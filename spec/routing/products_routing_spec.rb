require 'spec_helper'

describe 'routing to ProductsController' do
  it 'should route GET /shop to products#recent' do
    {:get => '/shop'}.should route_to(
      :controller => 'products',
      :action     => 'recent'
    )
  end
  
  it 'should route GET /stores/:store_slug/:slug-:id to products#show' do
    {get: '/stores/my-store/product-name-1'}.should route_to(
      controller: 'products',
      action:     'show',
      store_slug: 'my-store',
      slug:       'product-name',
      id:         '1'
    )
  end
end