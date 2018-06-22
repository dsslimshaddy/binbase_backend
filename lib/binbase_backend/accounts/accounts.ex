# lib/api13/accounts/accounts.ex

defmodule BinbaseBackend.Accounts do
	import Ecto.Query, warn: false

	alias BinbaseBackend.Accounts.User

	def get_user(id) do
		BinbaseBackend.Repo.get(User, id)
	end
end