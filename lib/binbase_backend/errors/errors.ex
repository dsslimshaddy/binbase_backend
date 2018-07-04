defmodule BinbaseBackend.Errors do

  @code_list [
    "invalid_params",
    "invalid_captcha",
    "not_found",
    "invalid_auth",
    "empty_return",
    "entity_error",
    "invalid_password",
  ]
  def getCode(str) do
    Enum.find_index(@code_list, fn(x) -> x == str end)
  end
  def returnCode(str \\ "empty_return") do
    {:error, %{"err_code" => getCode(str)} }
  end
end
