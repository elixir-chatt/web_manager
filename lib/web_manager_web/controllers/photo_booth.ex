defmodule WebManagerWeb.PhotoBoothController do
  use WebManagerWeb, :controller
  alias WebManager.Photos

  def listen(_conn, %{photos: photos}) do
    Photos.process_photos(photos)
  end
end
