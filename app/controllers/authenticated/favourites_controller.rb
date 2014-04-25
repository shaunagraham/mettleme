class Authenticated::FavouritesController < AuthenticatedController
  skip_before_filter :authorize

  before_filter :load_favourites, only: [:products, :stores]
  
  def create
    if @user.create_favourite(params[:favoured_type], params[:favoured_id])
      head :ok
    else
      head :bad_request
    end
  end
  
  def products
  end

  def stores
  end
  
  def destroy
    favourite = @user.favourites.find(params[:favoured_type], params[:favoured_id])
    favourite.destroy
    redirect_to :back
  end
  
  private
  def load_favourites
    @favourite_products = @user.favourites.products    
    @favourite_stores   = @user.favourites.stores    
  end
end
