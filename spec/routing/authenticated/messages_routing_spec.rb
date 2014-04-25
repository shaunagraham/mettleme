require 'spec_helper'

describe 'routing to Authenticated::FavouritesController' do
  it 'should route GET /user/messages/received to authenticated/messages#received' do
    {get: '/user/messages/received'}.should route_to(
      controller: 'authenticated/messages',
      action: 'received'
    )
  end

  it 'should route GET /user/messages/sent to authenticated/messages#sent' do
    {get: '/user/messages/sent'}.should route_to(
      controller: 'authenticated/messages',
      action: 'sent'
    )
  end

  it 'should route GET /user/messages/new to authenticated/messages#new' do
    {get: '/user/messages/new'}.should route_to(
      controller: 'authenticated/messages',
      action: 'new'
    )
  end
  
  it 'should route POST /user/messages to authenticated/messages#create' do
    {post: '/user/messages'}.should route_to(
      controller: 'authenticated/messages',
      action: 'create'
    )
  end  
end