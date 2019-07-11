defmodule WebManagerWeb.PhotoBoothController do
  use WebManagerWeb, :controller
  alias WebManager.Photos.Message

  def listen(conn, %{photos: photos}) do
    photos
    |> Enum.map(&Message.new/1)
    |> PhotoList.add_all
  end
end
