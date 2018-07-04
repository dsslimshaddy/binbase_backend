# lib/controllers/user_controller.ex

defmodule BinbaseBackendWeb.UserController do
  use BinbaseBackendWeb, :controller

  alias BinbaseBackend.Accounts
  alias BinbaseBackend.Auth

	def show(conn, %{"id" => id}) do
	  user = Accounts.get_user(id)

	  if user do
	    json(conn, %{"id"=>user.id,"email"=>user.email})
	  else
	    json(conn, :not_found)
	  end
	end

	def join(conn, %{"email" => email,"email" => password}) do
	  {:ok, user} = Auth.join(email, password)

	  if user do
	    json(conn, %{"id"=>user.id,"email"=>user.email})
	  else
	    json(conn, :not_found)
	  end
	end
	def check(conn, %{"email" => email}) do
	  {_, data} = Auth.from_email(email)
	  json(conn, data)
	end
end