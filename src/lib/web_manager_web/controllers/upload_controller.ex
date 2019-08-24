defmodule WebManagerWeb.UploadController do
  use WebManagerWeb, :controller
  alias WebManager.Photos

  # def upload(conn, %{id: photo_id}) do
  #   bytes = Plug.Conn.read_body(conn)
  #   Uploader.upload_to_s3(bytes, photo_id)
  # end

  def create(conn, _params) do
    Photos.upload_and_create(
      conn.assigns.jpg, 
      conn.assigns.group, 
      conn.assigns.index,
      conn.assigns.troll)
    
    # to test writing image  
    # filename = Path.join(System.cwd, "priv/static/images/out.jpg")
    # {:ok, file} = File.open(filename, [:write])
    # IO.binwrite(file, conn.assigns.jpg)
    # File.close(file)
    
    conn
    |> text("ok")
    
  end
end
