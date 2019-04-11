defmodule UiWeb.StatusController do
  use UiWeb, :controller

  def index(conn, _params) do
    statuses = []
    json conn, statuses
  end

  def show(conn, params) do
    IO.inspect params
    status = %{name: "John", status: "In"}
    json conn, status
  end

  def create(conn, params) do
    IO.inspect params
    status = %{name: "John", status: "In"}
    json conn, status
  end
end
