defmodule BinbaseBackend.Repo.Migrations.CreateOrderbooks do
  use Ecto.Migration

  def change do
    create table("orderbook") do
      add :maker_id, references("users")
      add :token_rel, :string, size: 4
      add :token_base, :string, size: 4
      add :kind, :integer
      add :amount, :float
      add :price, :float

      timestamps()
    end
    create table("finished_orderbook") do
      add :maker_id, references("users")
      add :taker_id, references("users")
      add :token_rel, :string, size: 4
      add :token_base, :string, size: 4
      add :kind, :integer
      add :amount, :float
      add :price, :float

      timestamps()
    end

    create(index("orderbook", [:token_rel, :token_base, :kind, :price]))
  end
end
