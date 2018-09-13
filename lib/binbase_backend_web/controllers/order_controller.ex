# lib/controllers/order_controller.ex

defmodule BinbaseBackendWeb.OrderController do
  	use BinbaseBackendWeb, :controller
	alias BinbaseBackend.Orders

  	def add(conn, %{"token_rel" => token_rel,"token_base" => token_base,"kind" => kind,"amount" => amount,"price" => price}) do
  		user_id = 1
  		case Orders.add_order(user_id, token_rel, token_base, kind, amount, price) do
			{:ok, order} -> 
				json(conn, %{"id"=>order.id})
			{:error, _} -> 
				json(conn, :not_found)
  		end
  	end

end66