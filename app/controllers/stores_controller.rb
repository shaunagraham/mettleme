class StoresController < ApplicationController
  def index
    process_search_params
    respond_to do |format|
      format.html # index.html.erb
      format.js { render "renew_results" }
    end       
  end
  
  def show
    @store    = Store.find_by_slug(params[:slug])
    
    if request.xhr?
      render partial: 'listings/stores/show' and return
    end    
  end

  private
  def process_search_params
    if params[:q] != nil 
      params[:q][:combinator] = 'and'
      params[:q][:groupings] = []
      custom_words = params["q"].delete('description_or_name_spaces_match_anything')
      if custom_words != nil
        custom_words.split(' ').each_with_index do |word, index|
          params[:q][:groupings][index] = {description_or_name_spaces_match_anything: word} 
        end
      end
    end
    ransack_opts = params[:q]
    ransack_opts[:s] = params[:sort] if params[:sort]
    @search=Store.order('created_at DESC').search(ransack_opts)
    @stores = @search.result(distinct: true).page(params[:page]).per(10)
  end
end
