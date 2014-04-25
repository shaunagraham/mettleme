class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery  
  
  before_filter :load_user  
  
  private
  def load_user
    @user = current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
end
