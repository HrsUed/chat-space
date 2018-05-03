require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region: 'ap-northeast-1'
  }

  case Rails.env
  when 'development', 'test'
    config.fog_directory = "devel-chatspace-upload-images"
    config.asset_host = "https://s3-ap-northeast-1.amazonaws.com/devel-chatspace-upload-images"
  when 'production'
    config.fog_directory = "chat-space-upload-images"
    config.asset_host = "https://s3-ap-northeast-1.amazonaws.com/chat-space-upload-images"
  end
end
