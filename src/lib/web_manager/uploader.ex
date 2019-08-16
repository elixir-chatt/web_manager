defmodule WebManager.Uploader do
  
  def upload_to_s3(bytes, photo_id) do
    :seth_upload_photo_to_s3_and_return_path
  end
  
  # this might need to point to some temp directory
  def photo_path(photo_id) do
    "#{photo_id}_digital_ocean_url_here"
  end
end