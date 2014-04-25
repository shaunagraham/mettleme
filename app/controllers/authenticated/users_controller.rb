class Authenticated::UsersController < AuthenticatedController
  skip_before_filter :authorize
  def edit
  end
  
  def sell
    #redirect_to edit_user_store_path and return if @user.seller?
    @user = current_user
    @store = Store.new
  end

  def change_password

  end
  
  def update
    if params[:current_password] # from change password view
        user = User.authenticate(@user.email,params[:current_password])
    else
      user= true
    end
    if  user and @user.update_attributes(params[:user])
      if params[:registered_seller]
        redirect_to edit_user_store_path, :notice => 'You can now set up your store'
      else
        redirect_to edit_user_path, :notice => 'Profile updated'        
      end
    else
      sign_in @user
      if params[:current_password]
        flash.now[:notice] = "Incorrect Current Password" unless user
        render :change_password
      else
        flash.now[:notice] = "Some errors occurred"
        render :edit
      end
    end    
  end
  
  def destroy
    # ...
  end
  
  def help
    
  end
  
  def subregion_options
    render partial: 'subregion_select'
  end

  def year_money

  end

  def month_money

  end

end
