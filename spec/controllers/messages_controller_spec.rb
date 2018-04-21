require 'rails_helper'
describe MessagesController do
  # ユーザとグループのインスタンスを生成（letなので遅延評価：初回呼び出し時に実行される）
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  describe 'GET #index' do

    context 'Signed in' do

      # このcontextはログイン前提のため共通前処理として実行
      # 引数のuserは上部でletにより宣言済み
      before do
        login user
        get :index, params: {group_id: group.id }
      end

      it 'assigns the requested messages to @messages' do
        expect(assigns(:message)).to be_a_new(Message)

        # messagesもインスタンス変数を生成している
        # expect(assigns(:messages)).to eq group.messages

      end

      it 'assigns the requested group to @group' do
        expect(assigns(:group)).to eq group
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    context 'Not signed in' do
      before do
        get :index, params: {group_id: group.id }
      end

      it 'redirect to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'Signed in' do

      before do
        login user
      end


      context 'Suceed to save a message' do
        subject {
          post :create, params: params
        }

        it 'メッセージの保存の確認' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it '意図した画面に遷移しているか確認' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'Fail to save a message' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create, params: invalid_params
        }


        it 'メッセージの保存がされていないことの確認' do
          expect{ subject }.not_to change(Message, :count)
        end

        it '意図したビューが表示されているか確認' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'Not Signed in' do

      it '意図した画面にリダイレクトできているか確認' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
