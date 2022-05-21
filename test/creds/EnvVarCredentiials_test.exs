defmodule AWSTest.Creds.EnvVarCredentials do
  use ExUnit.Case
  alias AWS.Creds.Credentials
  alias AWS.Creds.EnvVarCredentials
  
  setup do
    System.delete_env("AWS_ACCESS_KEY_ID")
    System.delete_env("AWS_SECRET_ACCESS_KEY")
    System.delete_env("AWS_SESSION_TOKEN")
  end

  test "returns error on unset access key" do
    {status, result} = Credentials.get(EnvVarCredentials.new())

    assert status == :error
    assert result == "Access key is not set."
  end

  test "returns error on empty access key" do
    {status, result} = Credentials.get(EnvVarCredentials.new())
    System.put_env("AWS_ACCESS_KEY_ID", "")

    assert status == :error
    assert result == "Access key is not set."
  end

  test "returns error on unset secret key" do
    System.put_env("AWS_ACCESS_KEY_ID", "asdf")

    {status, result} = Credentials.get(EnvVarCredentials.new())

    assert status == :error
    assert result == "Secret key is null."
  end

  test "returns error on empty secret key" do
    System.put_env("AWS_ACCESS_KEY_ID", "asdf")
    System.put_env("AWS_SECRET_ACCESS_KEY", "")

    {status, result} = Credentials.get(EnvVarCredentials.new())

    assert status == :error
    assert result == "Secret key is null."
  end

  test "returns cred set without session on unset session envvar" do
    System.put_env("AWS_ACCESS_KEY_ID", "access")
    System.put_env("AWS_SECRET_ACCESS_KEY", "secret")

    {status, result} = Credentials.get(EnvVarCredentials.new())

    assert status == :ok

    assert result.access_key == "access"
    assert result.secret_access_key == "secret"
    assert result.session_token == nil
  end

  test "returns cred set without session on empty session envvar" do
    System.put_env("AWS_ACCESS_KEY_ID", "access")
    System.put_env("AWS_SECRET_ACCESS_KEY", "secret")
    System.put_env("AWS_SESSION_TOKEN", "")

    {status, result} = Credentials.get(EnvVarCredentials.new())

    assert status == :ok

    assert result.access_key == "access"
    assert result.secret_access_key == "secret"
    assert result.session_token == nil
  end

  test "returns cred set with session on set session envvar" do
    System.put_env("AWS_ACCESS_KEY_ID", "access")
    System.put_env("AWS_SECRET_ACCESS_KEY", "secret")
    System.put_env("AWS_SESSION_TOKEN", "session")

    {status, result} = Credentials.get(EnvVarCredentials.new())

    assert status == :ok

    assert result.access_key == "access"
    assert result.secret_access_key == "secret"
    assert result.session_token == "session"
  end
end
