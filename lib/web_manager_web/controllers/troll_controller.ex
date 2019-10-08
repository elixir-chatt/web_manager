defmodule WebManagerWeb.TrollController do
  use WebManagerWeb, :controller
  alias WebManager.Photos
  require Logger

  def check(conn, _params) do
    troll_mode = Photos.last_troll()
    Photos.clear_troll()

    conn
    |> put_resp_header("cache-control", "no-store")
    |> json(%{troll: troll_mode})
  end
  
  def set(conn, _params) do
    Photos.create_troll(true)
    
    text conn, "Trolling!"
  end
end
