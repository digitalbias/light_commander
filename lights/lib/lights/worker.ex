defmodule Lights.Worker do
  use GenServer

  alias Blinkchain.Point

  defmodule State do
    defstruct [:timer, :colors]
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__ )
  end

  def init(_opts) do
    # Wait to start everything. Just to test this
    # :timer.sleep(2000)
    {:ok, ref} = :timer.send_interval(500, :draw_frame)

    state = %State{
      timer: ref,
      colors: Lights.colors()
    }

    {:ok, state}
  end

  def handle_info(:draw_frame, state) do
    [c1, c2, c3, c4, c5, c6, c7] = Enum.slice(state.colors, 0..6)
    tail = Enum.slice(state.colors, 1..-1)

    strip_count = Lights.strip_count() - 1

    Enum.each(0..strip_count, fn(n) ->
      Blinkchain.set_pixel(%Point{x: n, y: 0}, c1)
    end)

    # Blinkchain.set_pixel(%Point{x: 0, y: 0}, c1)
    # Blinkchain.set_pixel(%Point{x: 1, y: 0}, c2)
    # Blinkchain.set_pixel(%Point{x: 2, y: 0}, c3)
    # Blinkchain.set_pixel(%Point{x: 3, y: 0}, c4)
    # Blinkchain.set_pixel(%Point{x: 4, y: 0}, c5)
    # Blinkchain.set_pixel(%Point{x: 5, y: 0}, c6)
    # Blinkchain.set_pixel(%Point{x: 6, y: 0}, c7)
    # Blinkchain.set_pixel(%Point{x: 7, y: 0}, c1)
    # Blinkchain.set_pixel(%Point{x: 8, y: 0}, c2)
    # Blinkchain.set_pixel(%Point{x: 9, y: 0}, c3)
    # Blinkchain.set_pixel(%Point{x: 10, y: 0}, c4)
    # Blinkchain.set_pixel(%Point{x: 11, y: 0}, c5)
    # Blinkchain.set_pixel(%Point{x: 12, y: 0}, c6)
    # Blinkchain.set_pixel(%Point{x: 13, y: 0}, c7)
    # Blinkchain.set_pixel(%Point{x: 14, y: 0}, c1)
    # Blinkchain.set_pixel(%Point{x: 15, y: 0}, c2)
    # Blinkchain.set_pixel(%Point{x: 16, y: 0}, c3)
    # Blinkchain.set_pixel(%Point{x: 17, y: 0}, c4)
    # Blinkchain.set_pixel(%Point{x: 18, y: 0}, c5)
    # Blinkchain.set_pixel(%Point{x: 19, y: 0}, c6)
    # Blinkchain.set_pixel(%Point{x: 20, y: 0}, c1)
    # Blinkchain.set_pixel(%Point{x: 21, y: 0}, c2)

    # Blinkchain.set_pixel(%Point{x: 25, y: 0}, c2)
    # Blinkchain.set_pixel(%Point{x: 40, y: 0}, c3)
    # Blinkchain.set_pixel(%Point{x: 60, y: 0}, c4)
    # Blinkchain.set_pixel(%Point{x: 80, y: 0}, c5)
    # Blinkchain.set_pixel(%Point{x: 100, y: 0}, c6)
    # Blinkchain.set_pixel(%Point{x: 110, y: 0}, c1)
    # Blinkchain.set_pixel(%Point{x: 119, y: 0}, c2)

    Blinkchain.render()
    {:noreply, %State{state | colors: tail ++ [c1]}}
  end
end
