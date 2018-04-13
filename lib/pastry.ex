defmodule Pastry do
  @moduledoc """
  Pastry is a Elixir -fork- of 'Quiche'.

  Turn a map or keyword list into a query string.
  """

  alias Pastry.State.{Param, Query}

  @typedoc """
  Map or Keyword list
  """
  @type map_or_kw :: map | Keyword.t()

  @doc """
  Converts a given 'map' or 'keyword' to a query string.

  'opts' can be:

  * `:case`: "camel" or "pascal"
  * `:func`: An arity 1 function to be applied on keys
  """
  @spec to_query_string(map_or_kw, Keyword.t()) :: String.t()
  def to_query_string(values, opts \\ [])

  def to_query_string(values, opts) when is_map(values) do
    query = get_encoded_string(values, opts)

    Param.clean()
    Query.clean()

    cond do
      values == [] || values == %{} -> ""
      true -> "?" <> query
    end
  end

  def to_query_string(values, opts) do
    values
    |> Enum.into(%{})
    |> to_query_string(opts)
  end

  defp get_encoded_string(params, opts) do
    opt_case = opts[:case]
    func = opts[:func]

    Enum.each(params, fn {key, val} ->
      do_get_encoded_string(val, key, {opt_case, func})
    end)

    [Param.get(), Query.get()]
    |> List.flatten()
    |> Enum.join("&")
  end

  defp do_get_encoded_string(val, key, {opt_case, func}) when is_function(func) do
    new_key = apply(func, ["#{key}"])

    do_get_encoded_string(val, new_key, {opt_case, nil})
  end

  defp do_get_encoded_string(val, key, {opt_case, _func}) when is_list(val) do
    new_key = check_case_opt(key, opt_case)

    save_element(val, new_key, &Param.save/1)
  end

  defp do_get_encoded_string(val, key, {opt_case, _func}) do
    new_key = check_case_opt(key, opt_case)

    save_element([val], new_key, &Query.save/1)
  end

  defp check_case_opt(key, opt) do
    str_key = to_string(key)

    case opt do
      "camel" -> camelize(str_key)
      "pascal" -> pascalize(str_key)
      _ -> key
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
