defmodule BinbaseBackend.Repo.Migrations.UpdateUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :phishing_code, :string
    end
  end
end
