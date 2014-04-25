class ContactMailer < ActionMailer::Base
  def contact_email(params)
    @name               = params[:name]
    @reason_for_contact = params[:reason_for_contact]
    @username           = params[:username]
    @message            = params[:message]
    
    mail(to: 'james@jameswilding.net', from: params[:email], subject: 'Contact from Mettle Me website')
  end
end
