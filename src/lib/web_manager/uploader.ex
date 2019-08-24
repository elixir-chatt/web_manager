defmodule WebManager.Uploader do
  @bucket System.get_env("bucket_name")
  # def upload_to_s3(bytes, photo_id) do
  #   :seth_upload_photo_to_s3_and_return_path
  # end

  def upload_to_s3(jpg, group, index) do
    path = photo_path(group, index)
    @bucket
    |> ExAws.S3.put_object(path, jpg)
    |> ExAws.request!

    {:ok, s3_url(group, index)}
  end

  # this might need to point to some temp directory
  def s3_url(group, index) do
    "http://#{@bucket}.nyc3.digitalocean.com/#{photo_path(group, index)}"
  end
  
  def photo_path(group, index) do
    "#{group}/#{index}/pic.jpg"
  end
end
