class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]

  def index
    # indexビューでform_forヘルパーの引数に使用する場合に定義が必要
    @message = Message.new

    # N+1問題を避けるためにincludes
    # どの程度解消されるのか試してみたい
    @messages = @group.messages.includes(:user)

    @members = @group.users.inject([]) { |members, user| members << user.name }

    respond_to do |format|
      format.html
      format.json {
        @additional_messages = @group.get_messages_after_last_update(params[:latest_message_id])
      }
    end
  end

  def create
    # 以下のようにするとgroupsへのSELECT文が余計に入るので以下の記載の方が性能いい
    # また、この時はmessage_paramsにgroup_idが抜けるので、これもハッシュにしてマージする必要がある。
    # @message = Message.new(message_params)

    @message = @group.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html {
          redirect_to group_messages_path(@group), notice: "メッセージが送信されました。"
        }
        format.json
      end

    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = "メッセージを入力してください。"
      render :index
      # 以下の記載でも良いが、サーバ通信が余計に発生するので、できればrenderで済ませたい。
      # redirect_to group_messages_path(@group), alert: "メッセージを入力してください。"
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
    # createアクションでMessage.newとしてしまうとグループIDを取得できなくなるため、以下の通りハッシュにしてマージする必要が生じる。
    # せっかくアソシエーションを設定しているので、このような処理は非常に冗長であるために不採用。
    # params.require(:message).permit(:content, :image).merge({group_id: params[:group_id], user_id: current_user.id})
  end
end
