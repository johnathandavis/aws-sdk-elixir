defprotocol AWS.Creds.Credentials do
  alias AWS.Creds.CredentialSet

  @spec get(creds :: t) :: {:ok, CredentialSet.t} | {:error, String.t}
  def get(creds)
end