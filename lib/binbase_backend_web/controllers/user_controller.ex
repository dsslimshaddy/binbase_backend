# lib/api13_web/controllers/user_controller.ex

defmodule BinbaseBackendWeb.UserController do
  use BinbaseBackendWeb, :controller

  alias BinbaseBackendWeb.Accounts
  alias BinbaseBackendWeb.Accounts.User

	def show(conn, %{"id" => id}) do
	  user = Accounts.get_user(id)

	  if user do
	    json(conn, %{"id"=>user.id,"email"=>user.email})
	  else
	    json(conn, :not_found)
	  end
	end
end