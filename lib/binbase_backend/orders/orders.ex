# lib/api13/orders/orders.ex

defmodule BinbaseBackendWeb.Orders do
  import Ecto.Query, warn: false
  alias BinbaseBackendWeb.Repo

  alias BinbaseBackendWeb.Orders
  alias BinbaseBackendWeb.Orders.Orderbook

  def get_active_orders(token_rel, token_base, kind, ln \\ 20) do
    case kind do
      0 -> 
        Orderbook
        |> where([u], u.token_rel == ^token_rel and u.token_base == ^token_base and u.kind == ^kind and u.del == 0)
        |> order_by(asc: :price,asc: :inserted_at)
        |> limit(^ln)
        |> select([:token_rel,:token_base,:amount,:price, :inserted_at])
        |> BinbaseBackend.Repo.all

      1 ->
        Orderbook
        |> where([u], u.token_rel == ^token_rel and u.token_base == ^token_base and u.kind == ^kind and u.del == 0)
        |> order_by(desc: :price,asc: :inserted_at)
        |> limit(^ln)
        |> select([:token_rel,:token_base,:amount,:price, :inserted_at])
        |> BinbaseBackend.Repo.all

    end
  end

  def add_order(user_id, token_rel, token_base, kind, amount, price) do
    q = %Orderbook{
      maker_id: user_id,
      token_rel: token_rel,
      token_base: token_base,
      kind: kind,
      amount: amount,
      price: price,
    }
    BinbaseBackend.Repo.insert(q)
  end

end