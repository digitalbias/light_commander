defmodule Status.StorageTest do
  use ExUnit.Case

  setup do
    storage = start_supervised!(Status.Storage)
    %{storage: storage}
  end

  test "Get and Put", %{storage: storage} do
    status = %{"name" => "Joe", "status" => "In"}
    assert Status.Storage.get(storage, status["name"]) == :error

    assert Status.Storage.put(storage, status) == status

    assert Status.Storage.get(storage, status["name"]) == {:ok, "In"}
  end

  test "Get all the things", %{storage: storage} do
    name1 = "Joe"
    status1 = "In"
    Status.Storage.put(storage,  %{"name" => name1, "status" => status1})
    name2 = "Steve"
    status2 = "Out"
    Status.Storage.put(storage,  %{"name" => name2, "status" => status2})

    assert Status.Storage.list_all(storage) == %{name1 => status1, name2 => status2}
  end
end
