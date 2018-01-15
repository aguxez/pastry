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
        Enum.each(val, fn x ->
          state = "#{key}=#{x}"
          Param.save(state)
        end)
      else
        Enum.each([val], fn x ->
          state = URI.encode("#{key}=#{x}")
          Query.save(state)
        end)
      end
    end)

    [Param.get(), Query.get()]
    |> List.flatten()
    |> Enum.join("&")
  end
end
