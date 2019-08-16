defmodule WebManagerWeb.UploadController do
  use WebManagerWeb, :controller
  alias WebManager.Uploader
  
  def upload(conn, %{id: photo_id}) do
    bytes = Plug.Conn.read_body(conn)
    Uploader.upload_to_s3(bytes, photo_id)
  end
  
  def create(conn, _param) do
    
  end
end