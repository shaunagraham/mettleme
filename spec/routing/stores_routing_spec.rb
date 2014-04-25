require 'spec_helper'

describe 'routing to StoresController' do
  it 'should route GET /stores/:slug to stores#show' do
    {:get => '/stores/store-name'}.should route_to(
      :controller => 'stores',
      :action     => 'show',
      :slug       => 'store-name'
    )
  end
end