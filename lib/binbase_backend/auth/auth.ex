# lib/api13/auth/auth.ex

defmodule BinbaseBackend.Auth do
	import Ecto.Query, warn: false

	alias BinbaseBackend.Errors
	alias BinbaseBackend.Auth.Guardian
	alias BinbaseBackend.Accounts.User

	def from_email(email) do
	  user = 
	  User
	  |> where([u], u.email == ^email)
	  |> BinbaseBackend.Repo.one()

	  if user!= nil do
	  	{:ok, %{"email" => user.email}}
	  else
	  	Errors.returnCode("not_found")
	  end
	end
	def authenticate_user(email, given_password) do

	  User
	  |> where([u], u.email == ^email)
	  |> BinbaseBackend.Repo.one()
	  |> check_password(given_password)

	end

	defp check_password(nil, _), do: Errors.returnCode("not_found")

	defp check_password(user, given_password) do
	  case Comeonin.Argon2.checkpw(given_password, user.encrypted_password) do
	    true -> {:ok, user}
	    false -> Errors.returnCode("not_found")
	  end
	end

	def join(email, password) do
		with {:ok, user} <- BinbaseBackend.Repo.insert(User.changeset(%User{},%{email: email, password: password, password_confirmation: password})),
		     { :ok, jwt, _ } <- Guardian.encode_and_sign(%{id: user.id}, %{}, token_type: :access) do
		     	refresh_token = refresh_token_create()
		     	BinbaseBackend.Cache.set_kv(refresh_token, user.id)
		        {:ok, %{id: user.id, email: user.email, access_token: jwt,refresh_token: refresh_token}}
		end
	end	
	def login(email, password) do
	    with { :ok, user } <- authenticate_user(email, password),
	         { :ok, jwt, _ } <- Guardian.encode_and_sign(%{id: user.id}, %{}, token_type: :access) do
		     	refresh_token = refresh_token_create()
		     	BinbaseBackend.Cache.set_kv(refresh_token, user.id)
	           {:ok, %{id: user.id,access_token: jwt,refresh_token: refresh_token}}
	         else
	         _err -> Errors.returnCode("not_found")
	     end
	end
	def refresh_token_create() do
		min = 100000 #x100,000
		max = 100000000 #x10,00,00,000
		s = Hashids.new([
		 salt: "Pt8IuV8qYAfbHNygqNh6-j3tyn0njYpaY76j6kUVp",
		 min_len: 10,
		])
		cipher1 = Hashids.encode(s, DateTime.utc_now() |> DateTime.to_unix())
		cipher2 = Hashids.encode(s, Enum.random(min..max))
		cipher3 = Hashids.encode(s, Enum.random(min..max))
		Enum.join([cipher1,cipher3,cipher2], "-")
	end
end