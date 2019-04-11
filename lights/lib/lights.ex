defmodule Lights do
  @moduledoc """
  Documentation for Lights.
  """
  alias Blinkchain.Color
  require Logger

  @colors [
    Color.parse("#9400D3"), # Purple
    Color.parse("#4B0082"), # Purpleish
    Color.parse("#0000FF"), # Blue
    Color.parse("#00FF00"), # Green
    Color.parse("#FFFF00"), # Yellow
    Color.parse("#FFA500"), # Orange
    Color.parse("#FF0000") # Red
  ]

  @doc """
  Predefined colors we will use on the led strip
  """
  def colors, do: @colors

  def strip_count do
    Application.get_env(:lights_commander, :strip_count, 138)
  end
end
