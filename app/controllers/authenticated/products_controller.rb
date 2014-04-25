class Authenticated::ProductsController < AuthenticatedController
  skip_before_filter :authorize

  def index
    if !@user.seller?
      redirect_to register_seller_user_path, notice: 'Please register as a seller' and return
    elsif @user.store.nil?
      redirect_to edit_user_store_path, notice: 'Please create your store' and return
    else
      @products = @user.store.products
    end
  end
    
  def new
    @categories = Category.all
    @sub_categories = @categories.first.sub_categories
    if !@user.seller?
      redirect_to register_seller_user_path, notice: 'Please register as a seller' and return
    elsif @user.store.nil?
      redirect_to edit_user_store_path, notice: 'Please create your store' and return
    else
      @product = @user.store.products.new      
    end
    
    render 'edit'
  end
  
  def edit
    @product = @user.store.products.find(params[:id])
    @categories = Category.all
    @sub_categories = @categories.first.sub_categories
  end  
  
  def create
    @product = @user.store.products.build(params[:product])
    
    if @product.save
      redirect_to user_products_path, notice: 'Item created'
    else
      @categories = Category.all
      @sub_categories = @categories.first.sub_categories
      render :edit
    end
  end
  
  def update
    @product = @user.store.products.find(params[:id])
    
    if @product.update_attributes(params[:product])
      redirect_to user_products_path, notice: 'Item updated'
    else
      @categories = Category.all
      @sub_categories = @categories.first.sub_categories
      render :edit
    end
  end
  
  # DELETE /user/products/:id (eg. /user/products/1)
  #
  # Example:
  #
  #   product = create(:product)
  #   sign_in(product.store.user) and delete :destroy, id: product.id
  #
  #   product.persisted? # => false
  #   response.status    # 302
  #   response.location  # user_products_path
  #
  def destroy
    product = @user.products.find(params[:id])
    product.destroy
    redirect_to user_products_path, notice: 'Product deleted'
  end

  def stats
    if !@user.seller?
      redirect_to register_seller_user_path, notice: 'Please register as a seller' and return
    elsif @user.store.nil?
      redirect_to edit_user_store_path, notice: 'Please create your store' and return
    else
      @products = @user.store.products
    end
  end

  def sub_categories_by_category
    if params[:category_id].present?
      @sub_categories = Category.find(params[:category_id]).sub_categories.map{|a| [a.name, a.id]}
    else
      @sub_categories = []
    end
  end
end
