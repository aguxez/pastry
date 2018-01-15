# Pastry - Turn maps into query Strings.

## Pastry is a 'Quiche' for C# fork in Elixir.

### Usage
```elixir
iex> Pastry.to_query_string(%{param: ~w(this is a parameters list), words: "Elixir is fun!"})
"?param=this&param=is&param=a&param=parameters&param=list&words=Elixir%20is%20fun!"
```
