class StoresController < ApplicationController
  def index
    #@search = Store.search do
    #  fulltext params[:search] do
    #    fields(:name, :owner_name)
    #  end
    #  paginate :page => params[:page], :per_page => params[:per_page]
    #  with(:designer_ids, params[:designer_ids]) if params[:designer_ids].present?
    #  with(:letters, params[:letters]) if params[:letters].present? and !params[:letters].include?("@")
    #  #with(:season_ids, params[:season_ids]) if params[:season_ids].present?
    #  with(:style_ids, params[:style_ids]) if params[:style_ids].present?
    #  with(:trends, params[:trends]) if params[:trends].present?
    #  with(:country_continents, params[:country_continents]) if params[:country_continents].present?
    #
    #end
    #@stores = @search.results
    @stores = Store.search(params)
  end
  
  def show
    @store    = Store.find_by_slug(params[:slug])
    @products = @store.products.sorted(params[:sort_by]).paginate(page: params[:page], per_page: params[:per_page])
    
    if request.xhr?
      render partial: 'listings/stores/show' and return
    end    
  end
end
