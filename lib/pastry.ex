defmodule Pastry do
  @moduledoc """
  Pastry is a Elixir -fork- of 'Quiche'.

  Turn an Array into a query string.
  """

  alias Pastry.State.{Param, Query}

  @doc """
  Converts a given 'map' to a query string.
  """
  @spec to_query_string(map) :: String.t
  def to_query_string(values) when is_map(values) do
    string = get_encoded_string(values)

    Param.clean()
    Query.clean()

    "?" <> string
  end

  defp get_encoded_string(params) do
    Enum.each(params, fn({key, val}) ->
      if is_list(val) do
        save_element(val, key, &Param.save/1)
      else
        save_element([val], key, &Query.save/1)
      end
    end)

    [Param.get(), Query.get()]
    |> List.flatten()
    |> Enum.join("&")
  end

  defp save_element(val, key, fun) do
    Enum.each(val, fn x ->
      state = "#{key}=#{x}"
      fun.(state)
    end)
  end
end
