defmodule WebManagerWeb.TrollControllerTest do
  use WebManagerWeb.ConnCase
  alias WebManager.Photos

  test "GET /troll", %{conn: conn} do
    conn = get(conn, "/troll")
    assert text_response(conn, 200) =~ "Trolling"
  end
  
  test "GET /api/troll true", %{conn: conn} do
    Photos.create_troll true
    conn = get(conn, "/api/troll")
    assert json_response(conn, 200) == %{"troll" => true}
    
    refute WebManager.Photos.last_troll
  end

  test "GET /api/troll false", %{conn: conn} do
    Photos.create_troll false
    conn = get(conn, "/api/troll")
    assert json_response(conn, 200) == %{"troll" => false}
    
    refute WebManager.Photos.last_troll
  end

end
