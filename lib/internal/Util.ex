defmodule AWS.Util do
  
  @type formMap :: %{String.t => String.t}

  @spec form_url_encode(map :: formMap) :: String.t
  def form_url_encode(map) do
    encoded_elements = Enum.map(map, fn ({key, value}) ->
      URI.encode_www_form(Atom.to_string(key)) <> "=" <> URI.encode_www_form(value)
    end)
    Enum.join(encoded_elements, "&")
  end

end