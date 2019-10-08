defmodule WebManagerWeb.TrollController do
  use WebManagerWeb, :controller
  alias WebManager.Photos
  require Logger

  def check(conn, _params) do
    troll = Photos.last_troll()
    Logger.warn("Troll value of #{troll}")
    
    Photos.clear_troll()
    
    conn
    |> put_resp_header("cache-control", "no-store")
    |> json(%{troll: troll})
  end
  
  def set(conn, _params) do
    Photos.create_troll(true)
    
    text conn, "Trolling!"
  end
end
