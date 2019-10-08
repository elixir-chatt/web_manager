defmodule WebManagerWeb.TrollController do
  use WebManagerWeb, :controller
  alias WebManager.Photos

  def check(conn, _params) do
    troll = Photos.check_and_clear_troll()
    
    conn
    |> put_resp_header("cache-control", "max-age=0")
    |> json(%{troll: troll})
  end
  
  def set(conn, _params) do
    Photos.create_troll(true)
    
    text conn, "Trolling!"
  end
end
