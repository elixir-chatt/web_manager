defmodule WebManagerWeb.TrollController do
  use WebManagerWeb, :controller
  alias WebManager.Photos

  def check(conn, _params) do
    troll = Photos.check_and_clear_troll()
    
    json(conn, %{troll: troll})
  end
  
  def set(conn, _params) do
    Photos.create_troll(true)
    
    text conn, "Trolling!"
  end
end
