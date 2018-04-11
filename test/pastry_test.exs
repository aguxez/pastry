defmodule PastryTest do
  use ExUnit.Case
  doctest Pastry

  test "returns correct query string" do
    expected = "?param=this&param=list&words=Elixir%20is%20fun!"
    params = %{param: ~w(this list), words: "Elixir is fun!"}

    assert Pastry.to_query_string(params) === expected
  end

  test "returns correct camel case string" do
    expected = "?paramWords=this&paramWords=list&otherWords=Elixir%20is%20fun"
    params = %{param_words: ~w(this list), other_words: "Elixir is fun"}

    assert Pastry.to_query_string(params, case: "camel") === expected
  end

  test "returns correct pascal case string" do
    expected = "?SomeName=this&SomeName=list&StringMessage=a%20message"
    params = %{some_name: ~w(this list), string_message: "a message"}

    assert Pastry.to_query_string(params, case: "pascal") === expected
  end
end
