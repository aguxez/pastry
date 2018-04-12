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

  test "returns correct string using keyword list" do
    expected_normal = "?param=this&param=list&words=Elixir%20is%20fun!"
    params_normal = [param: ~w(this list), words: "Elixir is fun!"]

    expected_camel = "?paramWords=this&paramWords=list&otherWords=Elixir%20is%20fun"
    params_camel = [param_words: ~w(this list), other_words: "Elixir is fun"]

    expected_pascal = "?SomeName=this&SomeName=list&StringMessage=a%20message"
    params_pascal = [some_name: ~w(this list), string_message: "a message"]

    assert Pastry.to_query_string(params_normal) === expected_normal
    assert Pastry.to_query_string(params_camel, case: "camel") === expected_camel
    assert Pastry.to_query_string(params_pascal, case: "pascal") === expected_pascal
  end

  test "applies function on keys" do
    expected = "?PARAM=this&PARAM=is&PARAM=a&PARAM=list"
    params = %{param: ~w(this is a list)}

    assert Pastry.to_query_string(params, func: &String.upcase/1) === expected
  end
end
