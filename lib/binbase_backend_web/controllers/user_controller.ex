# lib/controllers/user_controller.ex

defmodule BinbaseBackendWeb.UserController do
  use BinbaseBackendWeb, :controller

  alias BinbaseBackend.Accounts
  alias BinbaseBackend.Auth
  alias BinbaseBackend.Errors

	def join(conn, %{"email" => email,"password" => password,"invite_code" => invite_code}) do
	  #,"captchaResponse" => captchaResponse
	  {:ok, user} = Auth.join(email, password, invite_code)

	  if user do
	    json(conn, %{"id"=>user.id,"email"=>user.email,"access_token"=>user.access_token,"refresh_token"=>user.refresh_token})
	  else
	    json(conn, Errors.returnCodeBare(1))
	  end
	end

	def check(conn, %{"email" => email}) do
	  {_, data} = Auth.from_email(email)
	  json(conn, data)
	end
	def login(conn, %{"email" => email,"password" => password,"g_auth" => g_auth}) do
	  {_, data} = Auth.login(email, password, g_auth)
	  json(conn, data)
	end
end