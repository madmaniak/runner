require 'aws-sdk'
require 'net/ssh'
require 'pry'

require_relative 'runner/cloud_formation/base'
require_relative 'runner/cloud_formation/rowlfbox'
require_relative 'runner/cloud_formation/es_cluster'
require_relative 'runner/route53/es_cluster'
require_relative 'runner/ssh/rowlfbox'
require_relative 'runner/ssh/es_cluster'

AWS.config(
  access_key_id:     ENV['AWS_ACCESS_KEY_ID'], 
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  session_token:     ENV['AWS_SESSION_TOKEN']
)
