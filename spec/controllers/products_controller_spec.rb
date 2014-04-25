require 'spec_helper'

describe ProductsController do
  describe 'GET #show' do
    it 'should load a product and render products/show' do
      product = create(:product)
      get :show, store_slug: product.store.slug, slug: product.slug, id: product.id
      assigns(:product).should == product
      response.should render_template 'products/show'
    end
  end
end
