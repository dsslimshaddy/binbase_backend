# lib/api13/auth/auth.ex

defmodule BinbaseBackendWeb.Auth do
	import Ecto.Query, warn: false
	alias BinbaseBackendWeb.Repo

	alias BinbaseBackendWeb.Accounts.User

	def authenticate_user(email, given_password) do

	  User
	  |> where([u], u.email == ^email)
	  |> BinbaseBackend.Repo.one()
	  |> check_password(given_password)

	end

	defp check_password(nil, _), do: {:error, "Incorrect email or password"}

	defp check_password(user, given_password) do
	  case Comeonin.Argon2.checkpw(given_password, user.encrypted_password) do
	    true -> {:ok, user}
	    false -> {:error, "Incorrect email or password"}
	  end
	end
	def login(conn, user) do
	  #conn
	  #|> Guardian.Plug.sign_in(user)
	  #|> assign(:current_user, user)
	end	
	def logout(conn) do
	  #conn
	  #|> Guardian.Plug.sign_out()
	end

end