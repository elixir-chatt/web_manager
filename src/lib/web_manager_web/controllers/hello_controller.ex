defmodule WebManagerWeb.HelloController do
  use WebManagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
