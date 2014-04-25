# Subclassed from clearance's sessions controller to allow for customisation.
class SessionsController < Clearance::SessionsController
  before_filter :remember_redirect_to
  
  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
 
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user 
      authentication.update_token(auth_hash)
      @next = edit_user_path(user)
      @notice = "Signed in!"
    else
      user = User.create_with_auth_and_hash(authentication,auth_hash)
      @next = edit_user_path(user)   
      @notice = "User created - confirm or edit details..."
    end
    sign_in(user)
    redirect_to @next, :notice => @notice
  end

   def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
      else
        flash[:notice] = "Bad email or password. Are you trying to register a new account?,  #{ view_context.link_to("Sign up", sign_in_path) }.".html_safe
        redirect_to(:back)
      end
    end
  end

  private
  def remember_redirect_to
    session[:redirect_to] = params[:redirect_to] if params[:redirect_to].present?
  end
  
  # URL after user sign in
  def url_after_create
    session[:redirect_to] || (( current_user and current_user.store) ? edit_user_store_path : edit_user_path)
  end
  
  def url_after_destroy
    # wipe remebered redirect_to 
    session[:redirect_to] = nil
    root_path
  end
end
