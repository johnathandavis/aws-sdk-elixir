defmodule AWS.Creds.CredentialSet do
  @type t :: %{
    access_key: String.t,
    secret_access_key: String.t,
    session_token: String.t,
  }
  @enforce_keys [:access_key, :secret_access_key]
  defstruct [
    :access_key,
    :secret_access_key,
    :session_token
  ] 
end