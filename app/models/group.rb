class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :group_users

  validates :name, presence: true, uniqueness: true

  def get_latest_message

    latest_message = (self.messages.size == 0) ? "まだメッセージはありません。" : self.messages.last.content

    latest_message = "画像が投稿されています" if latest_message == ""

    return latest_message

    # Tips
    # self.messages.order(created_at: :desc).limit(1)とすると、
    # Message::ActiveRecord_AssociationRelation < Relationクラスのオブジェクトが返される。
    # これはRelationクラスのサブクラスであり、これに対しては直接に属性値（content）を取得できない。
    # このオブジェクトから最新の一件のcontentだけを取得したい場合は、以下の方法がある。
    # (1)lastメソッドによって最後のレコードを取得
    # (2)recordsメソッドによってメッセージモデルオブジェクトの配列を取得し、index=0のオブジェクトのcontentを取得
  end
end
