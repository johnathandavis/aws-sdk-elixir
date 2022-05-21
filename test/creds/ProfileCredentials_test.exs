defmodule AWSTest.Creds.ProfileCredentials do
  use ExUnit.Case
  alias AWS.Creds.Credentials
  alias AWS.Creds.ProfileCredentials

  @profile_name "prof"
  @sample_root "./test/creds/sample_data"
  
  setup context do
    sample = context[:sample]
    case sample do
      nil -> :ok
      _ -> {:ok, file_path: "#{@sample_root}/#{sample}"}
    end
  end

  test "returns error on missing file" do
    file_path = "/Users/asdf/missing_file"
    {status, result} = Credentials.get(ProfileCredentials.new(@profile_name, file_path))

    assert status == :error
    assert result == "Failed to find profile configuration file in #{file_path}."
  end

  @tag sample: "missing_profile.ini"
  test "returns error on missing profile", context do
    {status, result} = Credentials.get(ProfileCredentials.new(@profile_name, context[:file_path]))

    assert status == :error
    assert result == "No profile with name #{@profile_name} found in file '#{context[:file_path]}'."
  end

  @tag sample: "missing_access_key.ini"
  test "returns error on missing access key", context do
    {status, result} = Credentials.get(ProfileCredentials.new(@profile_name, context[:file_path]))

    assert status == :error
    assert result == "The access key is missing in the profile #{@profile_name} from #{context[:file_path]}"
  end

  @tag sample: "empty_access_key.ini"
  test "returns error on empty access key", context do
    {status, result} = Credentials.get(ProfileCredentials.new(@profile_name, context[:file_path]))

    assert status == :error
    assert result == "The access key is empty in the profile #{@profile_name} from #{context[:file_path]}"
  end

  @tag sample: "missing_secret_key.ini"
  test "returns error on missing secret key", context do
    {status, result} = Credentials.get(ProfileCredentials.new(@profile_name, context[:file_path]))

    assert status == :error
    assert result == "The secret key is missing in the profile #{@profile_name} from #{context[:file_path]}"
  end

  @tag sample: "empty_secret_key.ini"
  test "returns error on empty secret key", context do
    {status, result} = Credentials.get(ProfileCredentials.new(@profile_name, context[:file_path]))

    assert status == :error
    assert result == "The secret key is empty in the profile #{@profile_name} from #{context[:file_path]}"
  end

end
