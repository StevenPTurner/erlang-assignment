%4 * (1 - 1/3 + 1/5 - 1/7 ...)
-module(calculate_pi).
-export([pi/0]).

pi() -> 4 * pi(0,0,1,1).

pi(250,PI,_,_) -> PI;

pi(N,PI,Add,Index) ->
  Whatever = (1/Index)*Add,
  io:fwrite("~3.3.0w " ,[Index]),
  pi(N+1,PI + Whatever,Add*-1,Index+2).
