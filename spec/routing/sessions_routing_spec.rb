require 'spec_helper'

describe 'routing to SessionsController' do
  it 'routes POST /session to sessions#create' do
    {:post => '/session'}.should route_to(
      :controller => 'sessions',
      :action     => 'create'
    )
  end
end