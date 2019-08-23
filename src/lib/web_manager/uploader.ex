defmodule WebManager.Uploader do

  # def upload_to_s3(bytes, photo_id) do
  #   :seth_upload_photo_to_s3_and_return_path
  # end

  def upload_to_s3(upload_params, photo_id) do
    file = upload_params.path
    bucket_name = System.get_env("BUCKET_NAME")
    s3_path = "path/on/s3"
    file
      |> ExAws.S3.Upload.stream_file
      |> ExAws.S3.upload(bucket_name, s3_path)
      |> ExAws.request!

    s3_url = "http://#{bucket_name}.nyc3.digitalocean.com/#{s3_path}"
    %{
      s3_url: s3_url
    }
  end

  # this might need to point to some temp directory
  def photo_path(photo_id) do
    "#{photo_id}_digital_ocean_url_here"
  end
end
