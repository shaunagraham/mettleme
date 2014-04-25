require 'spec_helper'

describe PaymentsController do
  describe 'GET #confirmed' do
    it 'should work' do
      get :confirmed
      response.should be_success
    end
  end
end
