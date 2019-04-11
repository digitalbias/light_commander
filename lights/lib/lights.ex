defmodule Lights do
  @moduledoc """
  Documentation for Lights.
  """
  alias Blinkchain.Color
  require Logger

  # Just note, colors hex are in the format of BGR, not RGB
  @status_colors %{
    "Dave" => [0, Color.parse("#0045FF")], # Orange
    "Amy" => [1, Color.parse("#82004B")], # Indego?
    "Emily" => [2, Color.parse("#0000FF")], # Red
    "Ben" => [3, Color.parse("#FF0000")], # Blue
    "Adam" => [4, Color.parse("#00FF00")], # Green
    "Laura" => [5, Color.parse("#00FFFF")], # Yellow
    "Afton" => [6, Color.parse("#9400D3")], # Purple
    "Unassigned" => [7, Color.parse("#FFFF00")] # Aqua
  }

  @doc """
  Predefined colors we will use on the led strip
  """
  def status_colors, do: @status_colors

  def strip_count do
    Application.get_env(:lights_commander, :strip_count, 8)
  end
end
