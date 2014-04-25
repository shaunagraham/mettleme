require 'spec_helper'

describe Authenticated::MessagesController do
  it {
    should be_kind_of AuthenticatedController
  }
  
  before :each do
    @user = create(:user)
  end
  
  describe 'GET #received' do
    it 'should load all received messages for a user and render a template' do
      messages = [create(:message, recipients: [@user]), create(:message, recipients: [@user])]
      
      sign_in(@user) and get :received
      
      assigns(:messages).should == messages
      response.should render_template 'authenticated/messages/received'
    end
  end
  
  describe 'GET #sent' do
    it 'should load all sent messages for a user and render a template' do
      messages = [create(:message, sender: @user), create(:message, sender: @user)]
      
      sign_in(@user) and get :sent
      
      assigns(:messages).should == messages
      response.should render_template 'authenticated/messages/sent'      
    end
  end
  
  describe 'GET #new' do
    it 'should initialize a new message and render a template' do
      sign_in(@user) and get :new
      assigns(:message).should be_kind_of Message
      assigns(:message).sender.should == @user
      response.should render_template 'authenticated/messages/new'
    end
  end
end
