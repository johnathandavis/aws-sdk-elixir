defmodule AWS.Clients.BaseClient do
  alias AWS.Request
  
  @spec exec(request:: Request.t()) :: String.t
  def exec(request) do

    full_url = create_url(request)
    headers_to_sign = create_signing_headers(request)
    {:ok, %{} = sig_data, _} = Sigaws.sign_req(full_url,
      region: request.region,
      service: request.service,
      headers: headers_to_sign,
      access_key: request.creds.access_key,
      secret:     request.creds.secret_key)
    
    request_headers = Map.merge(headers_to_sign, sig_data)
    request_headers
  end

  @spec create_signing_headers(request: Request) :: Request.HeaderMap
  def create_signing_headers(request) do
    initial_headers = case request.headers do
      nil -> %{}
      true -> request.headers
    end
    after_creds = case request.creds.session_token do
      nil -> initial_headers
      true -> Map.put(initial_headers, "X-Amz-Secure-Token", request.creds.session_token)
    end

    after_creds
  end

  @spec create_url(request: Request) :: String.t
  def create_url(request) do
    trimmed_endpoint = String.trim_trailing(request.endpoint, "/")
    if request.path do
      trimmed_endpoint <> request.path
    else
      trimmed_endpoint
    end
  end
end