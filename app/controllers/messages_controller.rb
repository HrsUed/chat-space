class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @messages = @group.messages
    @members = @group.users.inject([]) { |members, user| members << user.name }
  end

  def create
  end
end
