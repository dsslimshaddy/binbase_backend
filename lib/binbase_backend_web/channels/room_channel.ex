defmodule BinbaseBackendWeb.RoomChannel do
	use BinbaseBackendWeb, :channel
	
	alias BinbaseBackend.Orders

	def join("rooms:" <> token_slug, _params, socket) do
		[token_rel, token_base] = String.split(token_slug, "_")
    	orders_buy = Orders.get_active_orders(token_rel, token_base, 0)
    	orders_sell = Orders.get_active_orders(token_rel, token_base, 1)

    	{:ok, %{"orders_buy"=>orders_buy,"orders_sell"=>orders_sell}, socket}
    end

	def handle_in("new_order", %{"token_rel" => token_rel,"token_base" => token_base,"kind" => kind,"amount" => amount,"price" => price}, socket) do
		user_id = 1 #mock
	    broadcast!(socket, "order_added", %{"token_rel" => token_rel,"token_base" => token_base,"kind" => kind,"amount" => amount,"price" => price})
	    Orders.add_order(user_id, token_rel, token_base, kind, amount, price)
	    {:noreply, socket}
	end    
end

