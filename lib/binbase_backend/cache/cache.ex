defmodule BinbaseBackend.Cache do

 use GenServer

  @moduledoc """
  A simple ETS based cache for refresh tokens
  """


  def start do
    start([])
  end

  def start(args) do
    GenServer.start(__MODULE__, args)
  end

  def start_link do
    start_link([])
  end

  @doc """
  """
  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: :kv_cache)
  end

  def stop do
    GenServer.call(__MODULE__, :stop)
  end



  @doc """
  Retrieve information about the bucket identified by `key`
  """

  def get_kv(key) do
    GenServer.call(:kv_cache, {:get_kv, key})
  end

  @doc """
  Set information about the bucket identified by `key`
  """

  def set_kv(key, value) do
    GenServer.call(:kv_cache, {:set_kv, key, value})
  end


  ## GenServer Callbacks

  def init(args) do
    ets_table_name = Keyword.get(args, :ets_table_name)
    case :ets.info(ets_table_name) do
      :undefined ->
        :ets.new(ets_table_name, [:named_table, :public])
      _ ->
        nil
    end

    state = %{
      ets_table_name: ets_table_name,
    }

    {:ok, state}
  end
  def handle_call(:stop, _from, state) do
    {:stop, :normal, :ok, state}
  end

  def handle_call({:get_kv, key}, _from, state) do
    %{ets_table_name: tn} = state

    try do
      result =
        case :ets.lookup(tn, key) do
          [] ->
            {:ok, nil}

          [token] ->
            {:ok, token}
        end

      {:reply, result, state}
    rescue
      e ->
        {:reply, {:error, e}, state}
    end
  end
  def handle_call({:set_kv, key, value}, _from, state) do
    %{ets_table_name: tn} = state

    try do
      result =
        case :ets.insert(tn, {key, value}) do
          true ->
            {:ok, true}
          _ ->
            {:ok, false}
        end

      {:reply, result, state}
    rescue
      e ->
        {:reply, {:error, e}, state}
    end
  end
end