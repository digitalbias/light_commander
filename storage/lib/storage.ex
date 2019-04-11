defmodule Status.Storage do
  use GenServer

  # Client API

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def put(server, status) do
    GenServer.call(server, {:put, status})
  end

  def get(server, name) do
    GenServer.call(server, {:get, name})
  end

  def list_all(server) do
    GenServer.call(server, {:list_all})
  end

  # Server API

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:put, status_entry}, _from, statuses) do
    {:reply, status_entry, Map.put(statuses, status_entry["name"], status_entry["status"])}
  end

  def handle_call({:get, name}, _from, statuses) do
    {:reply, Map.fetch(statuses, name), statuses}
  end

  def handle_call({:list_all}, _from, statuses) do
    {:reply, statuses, statuses}
  end
end
