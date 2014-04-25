require 'spec_helper'

describe 'routing to Authenticated::FavouritesController' do
  it 'should route GET /user/favourites/products to authenticated/favourites#products' do
    {get: '/user/favourites/products'}.should route_to(
      :controller => 'authenticated/favourites',
      :action     => 'products'
    )
  end

  it 'should route GET /user/favourites/stores to authenticated/favourites#stores' do
    {get: '/user/favourites/stores'}.should route_to(
      :controller => 'authenticated/favourites',
      :action     => 'stores'
    )
  end
  
  it 'should route POST /user/favourites/product to authenticated/favourites#create' do
    {:post => '/user/favourites/product'}.should route_to(
      :controller => 'authenticated/favourites',
      :action     => 'create',
      :favoured_type => 'product'
    )
  end
  
  it 'should route DELETE /user/favourites/:favoured_type/:favoured_id/delete to authenticated/favourites#delete' do
    {delete: '/user/favourites/products/1'}.should route_to(
      controller:    'authenticated/favourites',
      action:        'destroy',
      favoured_type: 'products',
      favoured_id:   '1'
    )
  end
end