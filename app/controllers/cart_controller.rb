class CartController < ApplicationController
  before_filter :find_or_create_cart
  before_filter :remember_last_non_cart_page
  
  def show  
  end
  
  # GET /cart/add/:id (eg. /cart/add/1)
  #
  # Adds a product to a cart and redirects to cart_path.
  #
  # Example:
  #
  #   # setup
  #   product = create(:product)
  #   cart    = create(:cart)
  #
  #   # sanity check
  #   cart.products     # => []
  #
  #   # use cart in the controller
  #   session[:cart_id] = cart
  #
  #   # GET :add with a valid product id
  #   get :add, id: product.id
  #   
  #   cart.products     # => [product]
  #   response.status   # => 200
  #   response.template # => 'authenticated/carts/show'
  #
  #   # GET :add with an invalid product id
  #   request.env['HTTP_REQUEST_PATH'] = 'example.com'
  #   get :add, id: 1001
  #   response.status   # => 302
  #   response.location # => 'example.com'
  #
  def add
    if product = Product.find(params[:id])
      @cart.add(product)
      redirect_to cart_path
    else
      redirect_to :back, notice: 'No product found'
    end
  end
  
  # DELETE /cart/remove/:id (eg. /cart/remove/1)
  #
  # Removes a product from a cart and redirects to cart_path.
  def remove
    if item = @cart.items.find(params[:id])
      item.destroy
    end
    
    redirect_to cart_path
  end
  
  def checkout
    @user.orders.create(cart_id: @cart.id)
    redirect_to payment_confirmation_path
  end
  
  def update
    item = CartItem.find(params[:id])
    if item.update_attributes(params[:cart_item])
      redirect_to cart_path      
    else      
      redirect_to cart_path 
    end
  end
  
  private
  def find_or_create_cart
    cart_from_session || create_cart_for_session
  end
    
  def cart_from_session
    if session[:cart_id].present?
      if @user
        @cart = Cart.find_by_id_and_user_id(session[:cart_id], @user.id)
      else
        @cart = Cart.find_by_id(session[:cart_id])
      end
    end    
  end
  
  def create_cart_for_session
    # Note that @user may be nil here; this doesn't matter,
    # as non-logged-in users can have shopping carts.
    @cart = Cart.create(user: @user)
    session[:cart_id] = @cart.id    
  end
  
  def remember_last_non_cart_page
    if referrer_present? && referred_from_non_cart_page?
      session[:last_non_cart_page] = request.env["HTTP_REFERER"]      
    end
  end
  
  def referred_from_non_cart_page?
    referred_from_mettle_me_page? && referred_from_mettle_me_non_cart_page?
  end
  
  def referrer_present?
    request.env["HTTP_REFERER"].present?
  end  
  
  def referred_from_mettle_me_non_cart_page?
    request.env["HTTP_REFERER"] !~ %r(/cart)
  end
  
  def referred_from_mettle_me_page?
    URI.parse(request.env["HTTP_REFERER"]).host == request.host
  rescue URI::InvalidURIError
    false
  end
end
