class ContactController < ApplicationController
  def create
    if valid_params?
      ContactMailer.contact_email(params[:contact]).deliver
      redirect "Thanks! Your message has been sent and we'll be in touch soon"
    else
      redirect "Please complete all required form fields"
    end
  end
  
  private
  def valid_params?
    [:name, :email, :reason_for_contact, :message].all? { |key| params[key].present?}
  end
  
  def redirect(notice)
    redirect_to page_path('contact'), notice: notice
  end
end
