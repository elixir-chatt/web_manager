defmodule WebManagerWeb.UploadController do
  use WebManagerWeb, :controller
  alias WebManager.Uploader

  # def upload(conn, %{id: photo_id}) do
  #   bytes = Plug.Conn.read_body(conn)
  #   Uploader.upload_to_s3(bytes, photo_id)
  # end

  def upload(conn, %{"upload" => upload_params}) do
    resp = Uploader.upload_to_s3(upload_params)
    render(conn, resp: resp)
  end

  def create(conn, bin) do
    # a = Upload
    IO.inspect conn
    # resp = Uploader.upload_to_s3(user_params)
    json(conn, "ss")
  end

  # def create(conn, _param) do
  #
  # end
end
