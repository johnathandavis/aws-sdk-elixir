defmodule AWS.Request do
  alias AWS.Creds.CredentialSet
  alias Finch.Request, as: FinchRequest

  @type requestBody :: String.t | {:stream, Stream.t}
  @type headerMap :: %{String.t => String.t}

  @type t :: %{
    method: FinchRequest.method(),
    creds: CredentialSet.t,
    region: String.t,
    service: String.t,
    endpoint: String.t,
    path: String.t,
    body: requestBody,
    headers: headerMap
  }
  @enforce_keys [
    :creds,
    :region,
    :service,
    :endpoint,
  ]
  defstruct [
    :method,
    :creds,
    :region,
    :service,
    :endpoint,
    :path,
    :body,
    :headers
  ]
end