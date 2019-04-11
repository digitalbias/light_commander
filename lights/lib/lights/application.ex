defmodule Lights.Application do
  @moduledoc false
  @target Mix.Project.config()[:target]

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Lights.Supervisor]
    Supervisor.start_link(children(@target), opts)
  end

  def children("host") do
    []
  end

  def children(_target) do
    [ Lights.Worker ]
  end
end
