defmodule AWS.STS.Models do
  
  defmodule GetCallerIdentityResponse do
    @type t :: %{
      Account: String.t,
      Arn: String.t,
      UserId: String.t
   }
   defstruct [
    :account,
    :arn,
    :userId
  ]
end

end