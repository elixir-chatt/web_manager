defmodule WebManagerWeb.PageControllerTest do
  use WebManagerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "PhotoBooth"
  end
end
