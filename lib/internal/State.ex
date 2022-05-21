defmodule AWS.State do
  
  def init() do
    :ets.new(:aws_state, [:set, :protected, :named_table])
  end

  def connection_factory() do
    
  end

  def insert(key, val) do
    :ets.insert(:aws_state, {key, val})
  end

  def get(key) do
    :ets.lookup(:aws_state, key)
  end

end