defmodule BinbaseBackendWeb.PageController do
  use BinbaseBackendWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
