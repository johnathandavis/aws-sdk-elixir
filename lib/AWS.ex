defmodule AWS do
  alias AWS.Connection
  alias AWS.State
  @moduledoc """
  Documentation for `AWS`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AWS.hello()
      :world

  """
  def child_spec(arg) do
    %{
      id: AWS,
      start: {AWS, :start_link, [arg]}
    }
  end

  def start_link do
    State.init()
  end

  def init() do
    Connection.init()
    State.init()
  end
end
