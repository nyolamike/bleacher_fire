# ReactionsServer

The purpose of this services is to accomplish the following tasks
-1. Store the posted reactions, aggregated by content_id 
-The content_id refers to a map, of user_ids and values as reaction objects 
-This makes oparations like deleting a users reaction very fast 
-2. deleting users reactions 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `reactions_server` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:reactions_server, "~> 0.1.0"}
  ]
end
```


