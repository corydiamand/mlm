# load the libraries
require 'aws-sdk'

#load the connection
# AWS.config(
#   :access_key_id => 'AKIAJXKNFSW3MI23UVZQ',
#   :secret_access_key => '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')
# #create a s3 instance

# log requests using the default rails logger
AWS.config(:logger => Rails.logger)
# load credentials from a file
config_path = File.expand_path(File.dirname(__FILE__)+"/../aws.yml")
AWS.config(YAML.load(File.read(config_path)))