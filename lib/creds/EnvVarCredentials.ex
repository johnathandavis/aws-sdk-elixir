defmodule AWS.Creds.EnvVarCredentials do
  alias AWS.Creds.Credentials
  alias AWS.Creds.CredentialSet

  defmodule EnvVarCredentialsInstance do
    @type t :: %{
      prefix: String.t
    }
    @enforce_keys [:prefix]
    defstruct @enforce_keys
  end

  @spec new(prefix:: String.t) :: EnvVarCredentialsInstance.t
  def new(prefix \\ "") do
    %EnvVarCredentialsInstance{
      prefix: prefix
    }
  end

  defimpl Credentials, for: EnvVarCredentialsInstance do

    @access_key_envvar "AWS_ACCESS_KEY_ID"
    @secret_key_envvar "AWS_SECRET_ACCESS_KEY"
    @session_token_envvar "AWS_SESSION_TOKEN"

    @spec get(profile_creds :: EnvVarCredentialsInstance.t) :: CredentialSet.t
    def get(creds) do
      prefix = case creds.prefix do
        nil -> ""
        _ -> creds.prefix
      end
      access_key = System.get_env(prefix <> @access_key_envvar)
      secret_access_key = System.get_env(prefix <> @secret_key_envvar)
      session_token = System.get_env(prefix <> @session_token_envvar)
  
      cond do
        access_key == nil or access_key == "" -> {:error, "Access key is not set."}
        secret_access_key == nil or secret_access_key == "" -> {:error, "Secret key is null."}
        session_token == nil or session_token == "" -> {:ok, %CredentialSet{
          access_key: access_key,
          secret_access_key: secret_access_key,
        }}
        true -> {:ok, %CredentialSet{
            access_key: access_key,
            secret_access_key: secret_access_key,
            session_token: session_token
          }}
      end
    end
  end

end