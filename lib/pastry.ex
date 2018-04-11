defmodule Pastry do
  @moduledoc """
  Pastry is a Elixir -fork- of 'Quiche'.

  Turn an Array into a query string.
  """

  alias Pastry.State.{Param, Query}

  @doc """
  Converts a given 'map' to a query string.
  """
  @spec to_query_string(map, Keyword.t()) :: String.t()
  def to_query_string(values, opts \\ []) when is_map(values) do
    query = get_encoded_string(values, opts)

    Param.clean()
    Query.clean()

    "?" <> query
  end

  defp get_encoded_string(params, opts) do
    opt_case = Keyword.get(opts, :case, "ignore")

    Enum.each(params, fn {key, val} ->
      do_get_encoded_string(val, key, opt_case)
    end)

    [Param.get(), Query.get()]
    |> List.flatten()
    |> Enum.join("&")
  end

  defp do_get_encoded_string(val, key, opt) when is_list(val) do
    new_key = check_key_opt(key, opt)

    save_element(val, new_key, &Param.save/1)
  end

  defp do_get_encoded_string(val, key, opt) do
    new_key = check_key_opt(key, opt)

    save_element([val], new_key, &Query.save/1)
  end

  defp check_key_opt(key, opt) do
    str_key = to_string(key)

    case opt do
      "camel" -> camelize(str_key)
      "pascal" -> pascalize(str_key)
      "ignore" -> key
    end
  end

  defp camelize(key) do
    [first | rest] = String.split(key, "_")
    camelized =
      rest
      |> Enum.map(&String.capitalize(&1))
      |> Enum.join("")

    [first] ++ [camelized]
  end

  defp pascalize(key) do
    key
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end

  defp save_element(val, key, fun) do
    Enum.each(val, fn x ->
      state = "#{key}=#{x}"
      fun.(state)
    end)
  end
end
