class ApplicationController < ActionController::Base
  include Clearance::Authentication
  # before_filter :set_search
  protect_from_forgery  
  
  before_filter :load_user  

  # def set_search
  #   @search=Product.search(params[:q])
  # end
  
  private
  def load_user
    @user = current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
end
