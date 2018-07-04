
defmodule BinbaseBackend.Orders.Orderbook do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:maker_id, :token_rel, :token_base, :kind, :amount, :price, :updated_at]}
  schema "orderbook" do
    field(:maker_id, :integer)
    field(:token_rel, :string)
    field(:token_base, :string)
    field(:kind, :integer)
    field(:amount, :float)
    field(:price, :float)
    field(:del, :integer)

    timestamps()
  end

  @required_fields ~w(maker_id token_rel token_base kind amount price)
  @optional_fields ~w()

  def changeset(user, params \\ :empty) do
    user
    |> cast(params, @required_fields, @optional_fields)
    |> validate_number(:kind, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
    |> validate_tokens()
  end

  @base_list ["ETH", "BTC"]
  @rel_list %{
  	"BTC"=>["ETH","LTC"],
  	"ETH"=>["OMG","REQ"],
	}

  defp validate_tokens(changeset) do

  	rel = get_field(changeset, :token_rel)
  	base = get_field(changeset, :token_base)

  	if base in @base_list && rel in @rel_list[base] , do: changeset, else: token_incorrect_error(changeset)
  end

  defp token_incorrect_error(changeset) do
    add_error(changeset, :rel, "is not valid")
  end
    
end