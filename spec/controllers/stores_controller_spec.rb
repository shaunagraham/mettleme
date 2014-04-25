require 'spec_helper'

describe StoresController do
  describe 'GET #index' do
    it 'should load all stores and render stores/index' do
      10.times { create(:store) }
      get :index
      
      assigns(:stores).count.should == 10
      response.should render_template 'stores/index'
    end
  end
  
  describe 'GET #show' do
    it 'should load a store and render stores/show' do
      store = create(:store)
      get :show, id: store.id, slug: store.slug
      assigns(:store).should == store
      response.should render_template 'stores/show'
    end
  end
end
