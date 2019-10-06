defmodule WebManager.Uploader do
  @bucket System.get_env("bucket_name")
  @jpg_options [content_type: "image/jpeg", content_disposition: "inline"]
  # def upload_to_s3(bytes, photo_id) do
  #   :seth_upload_photo_to_s3_and_return_path
  # end
  
  # ExAws.S3.presigned_url(ExAws.Config.new(:s3), :get, "photobooth", )
  # config = 
  # method = :get
  # bucket = @bucket

  def upload_to_s3(jpg, group, index) do
    path = photo_path(group, index)
    @bucket
    |> ExAws.S3.put_object(path, jpg, @jpg_options)
    |> IO.inspect
    |> ExAws.request!
    |> IO.inspect

    {:ok, s3_url(group, index)}
  end

  # this might need to point to some temp directory
  def s3_url(group, index) do
    photo_path(group, index)
  end
  
  def signed_url(path) do
    ExAws.S3.presigned_url(
      ExAws.Config.new(:s3), 
      :get, 
      @bucket, 
      path, 
      [{:content_type, "image/jpeg"}, {:content_disposition, "inline"}])
  end
  
  def photo_path(group, index) do
    "#{group}/#{index}/pic.jpg"
  end
end
