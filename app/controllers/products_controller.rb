class ProductsController < ApplicationController

  def recent
    #@search = Product.search do
    #  fulltext params[:search] do
    #    fields(:name, :store)
    #  end
    #  with(:gender, params[:gender]) if params[:gender].present? and params[:gender] != 'both'
    #  paginate :page => params[:page], :per_page => params[:per_page]
    #  with(:sub_category_ids, params[:sub_category_ids]) if params[:sub_category_ids].present?
    #  with(:season_ids, params[:season_ids]) if params[:season_ids].present?
    #  with(:color_ids, params[:color_ids]) if params[:color_ids].present?
    #  with(:price, params[:start_price].to_i..params[:end_price].to_i) if params[:start_price].present? and params[:end_price].present?
    #  with(:featured_store_ids, params[:featured_store_ids]) if params[:featured_store_ids].present?
    #end
    #@products = @search.results
    @products = Product.search(params)
  end
  
  def show
    store    = Store.find_by_slug(params[:store_slug])
    @product = store.products.find_by_slug_and_id(params[:slug], params[:id])
    @message = Message.new
  end


end
