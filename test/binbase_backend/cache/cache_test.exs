defmodule BinbaseBackend.CacheTest do
  use ExUnit.Case

  test "kv caches and finds the correct data" do
  		k = "mykey"
  		v = "myvalue"
  		BinbaseBackend.Cache.set_kv(k,v)
  		assert BinbaseBackend.Cache.get_kv(k) == {:ok, {k, v}}
  		assert BinbaseBackend.Cache.get_kv("randomkeykey") == {:ok, nil}
  	end
end