defmodule Lights.Worker do
  use GenServer
  require Logger

  alias Blinkchain.Point

  defmodule State do
    defstruct [:starting_count, :timer, :status_colors]
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__ )
  end

  def init(_opts) do
    # Wait to start everything. Just let things get into a steady state
    :timer.sleep(2000)
    {:ok, ref} = :timer.send_interval(500, :draw_frame)

    state = %State{
      starting_count: 0,
      timer: ref,
      status_colors: Lights.status_colors()
    }

    {:ok, state}
  end

  def handle_info(:draw_frame, state) do
    strip_count = Lights.strip_count() - 1
    case state.starting_count do
      n when n in 0..8 ->
        draw_starting(strip_count)
      _ ->
        draw_status(state)
    end

    Blinkchain.render()
    {:noreply, %State{state | starting_count: state.starting_count + 1}}
  end

  def draw_starting(strip_count) do
    color = Blinkchain.Color.parse("#777777")

    Enum.each(0..strip_count, fn(n) ->
      Blinkchain.set_pixel(%Point{x: n, y: 0}, color)
    end)
  end

  def draw_status(state) do
    Enum.each(Map.keys(state.status_colors), fn(name) ->
      case Map.get(state.status_colors, name) do
        [index, default_color] ->
          Blinkchain.set_pixel(%Point{x: index, y: 0}, get_status_color(name, default_color))
        _ ->
          Logger.debug "Not in map"
      end
    end)
  end

  def get_status_color(name, default_color) do
    blank_color = Blinkchain.Color.parse("#000000")
    case Status.Storage.get(Status.Storage, name) do
      {:ok, "In"} ->
        default_color
      {:ok, "Out"} ->
        blank_color
      _ ->
        blank_color
    end
  end
end
