# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

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
|members|usersテーブルとgroupsテーブルの中間テーブル。どのユーザがどのチャットグループに属しているかの情報を格納する。|
|messages|チャットメッセージを格納するテーブル|

### usersテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|Primary Key|
|name|string|Not Null|
|email|string|Not Null, Unique|

#### アソシエーション

- has_many: members
- has_many: messages

### groupsテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|Primary Key|
|name|string|Not Null|

#### アソシエーション

- has_many: menbers
- has_many: messages

### membersテーブル

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
|body|text|Not Null|
|group_id|integer|Foreign Key|
|user_id|integer|Foreign Key|

#### アソシエーション

- belongs_to: user
- belongs_to: group
