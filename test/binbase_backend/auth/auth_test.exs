defmodule BinbaseBackend.AuthTest do
  use ExUnit.Case

  @endpoint BinbaseBackendWeb.Endpoint
  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BinbaseBackend.Repo)
  end

  test "POST /api/register" do
  		email = "a@b.com"
  		password = "123456789"
		#{:ok, token, _} = BinbaseBackend.Auth.Guardian.encode_and_sign(%{id: 1}, %{}, token_type: :access)
  		{:ok, json} = BinbaseBackend.Auth.join(email, password)
  		assert json.email == email
  	end
end