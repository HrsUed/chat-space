class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]

  def index
    @messages = @group.messages
    @members = @group.users.inject([]) { |members, user| members << user.name }
  end

  def create
    @messages = @group.messages
    if @messages << Message.new(message_params)
      redirect_to group_messages_path(@group)
    else
      render :index
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:content, :image).merge({group_id: params[:group_id], user_id: current_user.id})
  end
end
