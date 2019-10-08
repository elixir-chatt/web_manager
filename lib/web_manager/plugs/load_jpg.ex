defmodule WebManager.Plugs.LoadJpg do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    {:ok, jpg, _more} = read_body conn
    headers = Map.new conn.req_headers
    conn
    |> assign(:troll, Map.fetch!(headers, "troll"))
    |> assign(:jpg, jpg)
    |> assign(:index, Map.fetch!(headers, "index"))
    |> assign(:group, Map.fetch!(headers, "gts"))
  end
end