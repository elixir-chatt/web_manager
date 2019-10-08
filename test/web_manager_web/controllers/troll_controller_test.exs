defmodule WebManagerWeb.TrollControllerTest do
  use WebManagerWeb.ConnCase

  test "GET /troll", %{conn: conn} do
    conn = get(conn, "/troll")
    assert html_response(conn, 200) =~ "Trolling"
  end
end
