defmodule WebManagerWeb.PageController do
  use WebManagerWeb, :controller

  def index(conn, _param) do
    render(conn, "index.html")
  end
end
