# app/controllers/direct_messages_controller.rb

class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(params[:user_id])
    @direct_message = DirectMessage.new
  end

  def create
    @direct_message = current_user.sent_direct_messages.build(direct_message_params)
    if @direct_message.save
      redirect_to direct_messages_path, notice: 'ダイレクトメッセージが送信されました。'
    else
      @user = User.find(params[:direct_message][:recipient_id])
      render :new
    end
  end

  def index
    @received_messages = current_user.received_direct_messages
    @sent_messages = current_user.sent_direct_messages
  end

  def show
    @direct_message = DirectMessage.find(params[:id])
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:recipient_id, :body)
  end
end
