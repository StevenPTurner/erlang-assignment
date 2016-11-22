-module (fact).
-export ([factorial/1]).
-export ([area/1]).
-export ([each/1]).
-export([sort/1]).


factorial(0) -> 1;
factorial(N) when N > 0 and is_integer(N) ->
  N * factorial(N-1).

area({square,Side}) -> Side * Side;
area({rect,Side1,Side2}) -> Side1 * Side2;
area({circle,Radius}) -> 2 * math:pi() * Radius.

each([])->[];
each([H|T]) ->
  Area=area(H),
  io:fwrite("~w ",[Area]),
  each(T).

sort([Pivot|T]) ->
  sort([X || X <- T, X < Pivot]) ++
  [Pivot] ++
  sort([X || X <- T, X >=Pivot]);
sort([]) -> [].
