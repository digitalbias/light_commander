defmodule UiWeb.StatusController do
  use UiWeb, :controller

  def index(conn, _params) do
    statuses = Status.Storage.list_all(Status.Storage)
    json conn, statuses
  end

  def show(conn, params) do
    result = case Status.Storage.get(Status.Storage, params["id"]) do
      {:ok, status} ->
        %{"name" => params["id"], "status" => status}
      _ ->
        %{"name" => params["id"], "status" => "Unknown"}
    end
    json conn, result
  end

  def create(conn, params) do
    status = %{"name" => params["name"], "status" => params["status"]}
    result = Status.Storage.put(Status.Storage, status)
    json conn, result
  end
end
