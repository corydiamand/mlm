class HostedFilesController < ApplicationController
  before_filter :signed_in_user, only: :show
  before_filter :correct_user, only: :show

  def show
    s3 = AWS::S3.new
    s3_name = params[:id] + '.pdf'
    obj = s3.buckets['mlmclientportal'].objects["#{s3_name}"] #no request made
    url = obj.url_for(:read, expires: 3.minutes, response_content_disposition: "attachment")
    redirect_to url.to_s
  end
end
