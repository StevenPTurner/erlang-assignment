-module(calculate_pi).
-export([pi/0]).

pi() -> pi(0,1,1,false). %inital clause

pi(PI,_,_,true) -> PI;  %exit clause
pi(PI,Operation,Index,_) ->
  To_add = (4/Index) * Operation,
  Is_finished = (4/Index) < 0.00001,  %checks if at 5 decimal places
  pi(PI + To_add, Operation*-1, Index+2, Is_finished).
