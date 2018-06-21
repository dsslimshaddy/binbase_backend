# lib/api13/accounts/accounts.ex

defmodule BinbaseBackendWeb.Accounts do
	import Ecto.Query, warn: false
	alias BinbaseBackendWeb.Repo

	alias BinbaseBackendWeb.Accounts.User

	def get_user(id) do
		BinbaseBackend.Repo.get(User, id)
	end


end