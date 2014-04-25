require 'spec_helper'

describe 'routing to ContactController' do
  it 'should route POST /contact to contact#create' do
    {post: '/contact'}.should route_to('contact#create')
  end
end