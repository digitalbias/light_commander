defmodule UiWeb.StatusControllerTest do
  use UiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, Routes.status_path(conn, :index))
    assert json_response(conn, 200) == []
  end

  test "GET /:name", %{conn: conn} do
    conn = get(conn, Routes.status_path(conn, :show, "John") )
    assert json_response(conn, 200) == %{"name" => "John", "status" => "In"}
  end

  test "POST /", %{conn: conn} do
    conn = post(conn, Routes.status_path(conn, :create, %{"name" => "John", "status" => "In"}))
    assert json_response(conn, 200) == %{"name" => "John", "status" => "In"}
  end
end
