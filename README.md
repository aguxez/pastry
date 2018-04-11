# Pastry - Turn maps and keyword lists into query Strings.

## Pastry is a 'Quiche' fork in Elixir.

### Usage
```elixir
iex> Pastry.to_query_string(%{param: ~w(this is a parameters list), words: "Elixir is fun!"})
"?param=this&param=is&param=a&param=parameters&param=list&words=Elixir%20is%20fun!"

Pastry.to_query_string([param: ~w(this is a parameters list), words: "Elixir is fun!"])
"?param=this&param=is&param=a&param=parameters&param=list&words=Elixir%20is%20fun!"
```

### You can pass options as to which type of case to use

```elixir
# use "camel" or "pascal"
iex> Pastry.to_query_string([some_words: ~w(some list), text_word: "Pascal"], case: "pascal")
"?SomeWords=some&SomeWords=list&TextWord=Pascal"
...
iex> Pastry.to_query_string(%{some_words: "A word"}, case: "camel")
"?someWords=A%20word"
```
