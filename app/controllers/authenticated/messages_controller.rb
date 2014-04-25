class Authenticated::MessagesController < AuthenticatedController
  skip_before_filter :authorize
  before_filter :get_user

  def index
    @messages = @user.received_messages.paginate(:page => params[:page])

  end

  def received
    @messages = @user.received_messages
  end
  
  def sent
    @messages = @user.sent_messages
  end
  
  def new
    @message = Message.new
  end

  def create
    @to = User.find_by_email(params[:message][:to])
    message = @user.send_message(@to, params[:message][:topic], params[:message][:body])
    if message.valid?
      flash[:notice] = "message sent"
    else
      flash[:notice] = "message not sent"
    end
    redirect_to user_messages_path
  end

  def reply
    @reply_message = Message.find(params[:message][:reply_message_id])
    message = @user.reply_to(@reply_message, params[:message][:topic], params[:message][:body])
    if message.valid?
      flash[:notice] = "reply message sent"
    else
      flash[:notice] = "reply message not sent"
    end
    redirect_to user_message_trail_message_path(@reply_message)
  end

  def trail_message
    @message = Message.find(params[:message_id])
    @reply_message = Message.new
  end

  def destroy_multiple
    Message.destroy_multiple(@user, params[:message_ids])
    respond_to do |format|
      format.html { redirect_to user_messages_path }
      format.json { head :no_content }
    end
  end

  def get_user
    @user = current_user
  end
end
