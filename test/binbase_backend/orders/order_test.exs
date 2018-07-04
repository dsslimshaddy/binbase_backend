defmodule BinbaseBackend.OrderTest do
  use ExUnit.Case

  @endpoint BinbaseBackendWeb.Endpoint
  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BinbaseBackend.Repo)
  end

  test "POST /api/add" do
  		{:ok, user} = BinbaseBackend.Auth.join("a@b.com", "123456789")
		{:ok, json} = BinbaseBackend.Orders.add_order(user.id, "ETH", "BTC", 0, 1.0, 0.1)
  		assert json.amount == 1
  	end
end
