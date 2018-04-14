# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.3.1p112

2.3.1p112

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## データベース設計

### テーブル一覧

以下のテーブルを定義。

|Table Name|Abstracts|
|----------|---------|
|users|ユーザ情報を格納する|
|groups|チャットグループ情報を格納する|
|group_user|usersテーブルとgroupsテーブルの中間テーブル。どのユーザがどのチャットグループに属しているかの情報を格納する。|
|messages|チャットメッセージを格納するテーブル|


### usersテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|Primary Key|
|name|string|Not Null|
|email|string|Not Null, Unique|


#### アソシエーション

- has_many: group_user
- has_many: groups, through: group_users
- has_many: messages

### groupsテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|Primary Key|
|name|string|Not Null|

#### アソシエーション

- has_many: group_user
- has_many: users, through: group_users
- has_many: messages

### group_userテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|Primary Key|
|user_id|integer|Not Null, Foreign Key|
|group_id|integer|Not Null, Foreign Key|

#### アソシエーション

- belongs_to: user
- belongs_to: group

### messagesテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|Primary Key|
|content|text|Not Null|
|image|string||
|group_id|integer|Foreign Key|
|user_id|integer|Foreign Key|

#### アソシエーション

- belongs_to: user
- belongs_to: group
