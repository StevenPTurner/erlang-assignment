-module(bigdata).
-export([pi/0]).
-export([count_unique/1]).
-export([unique/1]).
-export([count/1]).

pi() -> pi(0,1,1,false). %inital clause
pi(PI,_,_,true) -> PI;  %exit clause
pi(PI,Operation,Index,_) ->
  To_add = (4/Index) * Operation,
  Is_finished = (4/Index) < 0.00001,  %checks if at 5 decimal places
  pi(PI + To_add, Operation*-1, Index+2, Is_finished).

count(List) -> count(List,0).
count([],Length) -> Length;
count([_|T],Length) ->
  count(T,Length+1).

unique([]) -> [];
unique([H|T]) ->
  [H] ++ unique([X || X <- T, X /= H]).

count_unique(List) ->
  Unique = unique(List),
  io:fwrite("~w~n " , [Unique]),
  count(Unique).
