class Authenticated::StoresController < AuthenticatedController
  skip_before_filter :authorize

  def edit
    redirect_to register_seller_user_path and return unless @user.seller?

    if @user.store.present?
      @store = @user.store
    else
      @store = Store.new(user: @user)
    end
  end

  def create
    @store = Store.new(params[:store].merge(user: @user))

    if params[:preview_button]
      if !@store.valid?
        params.delete :preview_button
        flash.now[:notice] = 'Please check all required fields'
      end
      render :edit
    else
      if @store.save
        flash[:notice] = "Successfully created store."
        redirect_to root_path
      else
        flash.now[:notice] = 'Please check all required fields'
        render :edit
      end
    end
  end

  def update
    @store = @user.store

    if params[:preview_button]
      if !@store.valid?
        params.delete :preview_button
        flash.now[:notice] = 'Please check all required fields'
      end
      render :edit
    else
       if @store.update_attributes(params[:store])
        redirect_to edit_user_store_path, notice: 'Your store has been updated!'
       else
        flash.now[:notice] = 'Please check all required fields'
        render :edit
      end
    end
  end

  def destroy
    store = @user.store
    store.destroy if store
    redirect_to edit_user_path
  end

  def subregion_options
    render partial: 'subregion_select'
  end

   def settings

   end

  def store_items
    @store = @user.store
  end

  def analytics

  end

end
