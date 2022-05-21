defmodule AWSTest.Util do
  use ExUnit.Case
  alias AWS.Util
  
  test "returns correctly formatted form encoded string" do

    m = %{"Action": "GetCallerIdentity", "Version": "2011-06-15"}

    val = Util.form_url_encode(m)

    assert val == "Action=GetCallerIdentity&Version=2011-06-15"
  end

  test "returns correctly escaped form encoded string" do

    m = %{"Action": "GetCallerIdentity", "Version": "2011-06-15"}

    val = Util.form_url_encode(m)

    assert val == "Action=GetCallerIdentity&Version=2011-06-15"
  end

end
