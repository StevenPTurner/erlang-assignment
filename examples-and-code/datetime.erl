-module(datetime).
-export([nowtime/0,nowtime/1,nowtime/2]).
-export([go/0]).
-export([go10/1]).
-export([goshake/1]).
-export([shakefile/2]).



nowtime()->
  [date(),time()].

nowtime(Pid)->
  Pid ! {self(),[date(),time()]}.

nowtime(Pid,N)->
  timer:sleep(N),
  Pid ! {self(),[date(),time()]}.

go()->
  Pid=spawn(datetime,nowtime,[self()]),
  receive
    {From,Msg}->
      io:fwrite("~w",[Msg]);
    _Other -> {error, unknown}
end.

go10(10)->10;
go10(N)->
  Pid=spawn(datetime,nowtime,[self(),N*1000]),
  go10(N+1),
  receive
  {From,Msg}->
    io:fwrite("~w  ",[From]),
    io:fwrite("~w~n",[Msg]);
  _Other -> {error, unknown}
  end.

shakefile(Pid,F)->
  Count=shake:uniquelist(F),
  Pid ! {self(),{F,Count}}.

goshake([])->[];
goshake([H|T])->
  Pid=spawn(datetime,shakefile,[self(),H]),
  goshake(T),
  receive
    {From,Msg}->
      {F,C}=Msg,
      io:put_chars([F]),
      io:fwrite(" ~w~n",[C]);
    _Other -> {error, unknown}
  end.
