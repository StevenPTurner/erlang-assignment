-module (basic).
-export([mirror/1]).
-export([count/1]).
-export([area/1]).
-export([area/2]).

mirror(Anything) -> Anything.

count(10) -> 010;
count(N) ->
  io:fwrite("~3.3.0w " ,[N]),
  count(N+1).

area(Side) ->
  Side * Side.
area(Side1,Side2) ->
  Side1 * Side2.
