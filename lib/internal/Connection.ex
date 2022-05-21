defmodule AWS.Connection do
  
  def init() do
    Finch.start_link(name: ConnectionFactory)
  end

  def request(request) do
    Finch.request(ConnectionFactory)
  end
end