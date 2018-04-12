class GroupsController < ApplicationController
  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(name: group_params[:name])

    if @group.save

      # デフォルトでは1要素目に""が入るので、それをselectで除外
      group_params[:user_ids].select { |u| u != "" }.each do |user_id|
        @user = User.find(user_id)

        # 通常ありえないが、同一ユーザが指定された場合は重複登録をスキップ
        if @group.users.include?(@user)
          next
        else
          unless @group.users << @user
            # メンバー追加でfalseが発生したらグループを削除する
            @group.destroy
            render :new
          end
        end
      end

      redirect_to :root
    else
      render :new
    end

  end

  def edit
  end

  def update
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
