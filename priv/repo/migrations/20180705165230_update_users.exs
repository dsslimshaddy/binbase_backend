defmodule BinbaseBackend.Repo.Migrations.UpdateUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :invited_by, :integer, default: 0
    end
    create(index("users", [:invited_by]))
  end
end
