# cache/supervisor.ex

defmodule BinbaseBackend.Cache.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(BinbaseBackend.Cache, [[ets_table_name: :ets_jwt_refresh]]),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
