-module(unique).
-export([count/1]).
-export([count_unique/1]).

count_unique(List) ->
  A=unique(List),
  count(A).

count(List) -> count(List,0).
count([],Length) -> Length;
count([_|T],Length) ->
  count(T,Length+1).

unique([]) -> [];
unique([H|T]) ->
  [H] ++ unique([X || X <- T, X /= H]).
