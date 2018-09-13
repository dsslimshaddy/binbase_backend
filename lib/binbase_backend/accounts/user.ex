defmodule BinbaseBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:encrypted_password, :string)
    field(:invited_by, :integer)
    field(:phishing_code, :string)
    field(:confirmed, :boolean, default: false)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    field(:invite_code, :string, virtual: true)

    timestamps()
  end

  @required_fields ~w(email password password_confirmation)
  @optional_fields ~w(invited_by phishing_code)
  @salt Hashids.new([
    salt: "bhd7i7FPegcSqHlWxews",
    min_len: 10,
  ])

  def changeset(user, params \\ :empty) do
    cset = user
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:password, min: 0)
    |> validate_password_confirmation() 
    |> unique_constraint(:email)
    |> put_change(:encrypted_password, Comeonin.Argon2.hashpwsalt(params[:password]))

    if params[:invite_code] != "" do
      cset |> put_change(:invited_by, Hashids.decode(@salt, params[:invite_code]))
    else
      cset
    end
  end

  defp validate_password_confirmation(changeset) do
    case get_change(changeset, :password_confirmation) do
      nil ->
        password_incorrect_error(changeset)

      confirmation ->
        password = get_field(changeset, :password)
        if confirmation == password, do: changeset, else: password_mismatch_error(changeset)
    end
  end
  defp password_mismatch_error(changeset) do
    add_error(changeset, :password_confirmation, "Passwords does not match")
  end

  defp password_incorrect_error(changeset) do
    add_error(changeset, :password, "is not valid")
  end
    
end