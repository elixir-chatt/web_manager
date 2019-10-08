defmodule WebManager.Plugs.LoadJpg do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    {:ok, jpg, _more} = read_body conn
    headers = Map.new conn.req_headers
    
    
    conn
    |> verify(headers, System.get_env("TAKE_FIVE_API_KEY"))
    |> assign(:troll, Map.fetch!(headers, "troll"))
    |> assign(:jpg, jpg)
    |> assign(:index, Map.fetch!(headers, "index"))
    |> assign(:group, Map.fetch!(headers, "gts"))
  end
  
  def verify(conn, %{"api-key" => key}, key), do: conn
  def verify(conn, _, _) do
    conn
    |> put_status(:unauthorized) 
    |> halt
  end
end