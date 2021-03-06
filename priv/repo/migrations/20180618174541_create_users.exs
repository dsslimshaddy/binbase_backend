defmodule BinbaseBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table("users") do
      add(:email, :string)
      add(:encrypted_password, :string, null: false)
      add(:confirmed, :boolean, default: false)
      add(:ga_secret, :string)

      timestamps()
    end

    create(unique_index("users", [:email], name: :unique_emails))
  end
end
