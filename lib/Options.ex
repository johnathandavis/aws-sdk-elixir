defmodule AWS.Clients.Options do
  @type t :: %{
    region: String.t,
    creds: integer
  }
  defstruct [
    :region,
    :creds,
  ]
end