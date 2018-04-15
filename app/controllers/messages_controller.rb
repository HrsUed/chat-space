class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]

  def index
    # N+1問題を避けるためにincludes
    # どの程度解消されるのか試してみたい
    @messages = @group.messages.includes(:user)
  end

  def create
    # @message = Message.new(~)とするとgroupsへのSELECT文が余計に入るのでこちらの方が性能いい
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group)
    else
      redirect_to group_messages_path(@group), alert: "メッセージを入力してください。"
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
    @members = @group.users.inject([]) { |members, user| members << user.name }
  end

  def message_params
    params.require(:message).permit(:content, :image).merge({group_id: params[:group_id], user_id: current_user.id})
  end
end
