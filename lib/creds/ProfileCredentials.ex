defmodule AWS.Creds.ProfileCredentials do
  alias AWS.Creds.Credentials
  alias AWS.Creds.CredentialSet

  defmodule ProfileCredentialsInstance do
    @type t :: %{
      profile_name: String.t,
      file_path: String.t
    }
    @enforce_keys [:profile_name, :file_path]
    defstruct @enforce_keys
  end

  @default_cred_path Path.join([System.user_home!(), ".aws", "credentials"])

  @spec new(profile_name :: String.t, file_path :: String.t) :: ProfileCredentialsInstance.t
  def new(profile_name, file_path \\ @default_cred_path) do
    %ProfileCredentialsInstance{
      profile_name: profile_name,
      file_path: file_path
    }
  end

  defimpl Credentials, for: ProfileCredentialsInstance do

    @spec get(profile_creds :: ProfileCredentialsInstance.t) :: CredentialSet.t
    def get(profile_creds) do
      get(profile_creds.profile_name, profile_creds.file_path)
    end

    defp get(profile_name, file_path) do
      result = File.read file_path
      case result do
        {:error, _} -> {:error, "Failed to find profile configuration file in #{file_path}."}
        {:ok, ini_text} ->
          ini = Ini.decode(ini_text)
          profile = ini[String.to_atom(profile_name)]
          find_creds(profile, profile_name, file_path)
      end
    end

    defp find_creds(profile, profile_name, file_path) when is_nil(profile) do
      {:error, "No profile with name #{profile_name} found in file '#{file_path}'."}
    end
    
    defp find_creds(profile, profile_name, file_path) when is_map(profile) do
      access_key = profile[:aws_access_key_id]
      secret_key = profile[:aws_secret_access_key]

      case {access_key, secret_key} do
        {nil, _} -> {:error, "The access key is missing in the profile #{profile_name} from #{file_path}"}
        {"", _} -> {:error, "The access key is empty in the profile #{profile_name} from #{file_path}"}
        {_, nil} -> {:error, "The secret key is missing in the profile #{profile_name} from #{file_path}"}
        {_, ""} -> {:error, "The secret key is empty in the profile #{profile_name} from #{file_path}"}
        _ -> {:ok, %CredentialSet{
            access_key: access_key,
            secret_access_key: secret_key
          }}
      end
    end
  end
end