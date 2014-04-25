require 'spec_helper'

describe 'routing to PaymentsController' do
  it 'should route GET /payment/confirmed to payments#confirmed' do
    {get: '/payment/confirmed'}.should route_to('payments#confirmed')
  end
end