class HostedFilesController < ApplicationController
  before_filter :authenticate, only: :show
  before_filter :correct_user, only: :show

  def show
    s3_name = params[:id] + '.pdf'
    connection = AWS::S3::Base.establish_connection!(
      access_key_id: 'AKIAJXKNFSW3MI23UVZQ',
      secret_access_key: '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')
    url = AWS::S3::S3Object.url_for(s3_name, 'mlmclientportal', expires_in: 2.minutes)
    redirect_to url
  end
end
