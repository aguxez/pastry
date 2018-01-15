defmodule PastryTest do
  use ExUnit.Case
  doctest Pastry

  test "returns correct query string" do
    expected = "?param=this&param=list&words=Elixir%20is%20fun!"
    params = %{param: ~w(this list), words: "Elixir is fun!"}

    assert Pastry.to_query_string(params) === expected
  end
end
