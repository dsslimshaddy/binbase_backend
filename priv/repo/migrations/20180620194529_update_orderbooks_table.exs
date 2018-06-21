defmodule BinbaseBackend.Repo.Migrations.UpdateOrderbooksTable do
  use Ecto.Migration

  def change do

    alter table("orderbook") do
      add :del, :integer, default: 0
    end
    create(index("orderbook", [:del]))
    create(index("finished_orderbook", [:maker_id, :taker_id]))

  end
end
