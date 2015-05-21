require 'aws-sdk'

require_relative 'runner/cloud_formation/base'
require_relative 'runner/cloud_formation/rowlfbox'
require_relative 'runner/cloud_formation/es_cluster'

AWS.config(
  access_key_id:     ENV['AWS_ACCESS_KEY_ID'], 
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  session_token:     ENV['AWS_SESSION_TOKEN']
)
