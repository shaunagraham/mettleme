# Subclassed from clearance's sessions controller to allow for customisation.
class UsersController < Clearance::UsersController
  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render 'sessions/new'
    end
  end  
  
  private
  # URL after user sign in
  def url_after_create
    edit_user_path
  end

 
end
