defmodule AWS.Clients.STS do
  alias AWS.STS.Models
  alias AWS.Options

  @type t :: %{
    get_caller_identity: String.t,
    line_number: integer
  }
  
  @spec create_client(Options.t) :: t
  def create_client(options) do
    
    
  end

end