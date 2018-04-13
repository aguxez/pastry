# Pastry - Turn maps and keyword lists into query Strings.

## Pastry is a [Quiche](http://github.com/chrismissal/quiche) fork in Elixir. [![Build Status](https://travis-ci.org/aguxez/pastry.svg?branch=master)](https://travis-ci.org/aguxez/pastry)

### Install
```elixir
{:pastry, "~> 0.3.0"}
```

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

### And if passing case options is not enough
You can just pass an arity 1 function with the `:func` option

```elixir
iex> Pastry.to_query_string([text_message: "some word"], func: &String.upcase/1)
"?TEXT_MESSAGE=some%20word"
```
