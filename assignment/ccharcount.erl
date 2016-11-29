-module (ccharcount).
-export ([load/1,count/3,go/2,join/2,split/2]).

load(F)->
  {ok, Bin} = file:read_file(F),
  List=binary_to_list(Bin),
  Length=round(length(List)/20),
  Ls=string:to_lower(List),
  Sl=split(Ls,Length),
  io:fwrite("Loaded and Split~n"),
  Result=countsplit(Sl,[]),
  Result.

%
countsplit([],R)->R;
countsplit([H|T],R)->
  Pid=spawn(ccharcount,go,[self(),H]),
  receive
    {From,Result}->
      R2=join(R,Result),
      countsplit(T,R2);
    _Other -> {error, unkown}
  end.
%
join([],[])->[];
join([],R)->R;
join([H1 |T1],[H2|T2])->
  {C,N}=H1,
  {C1,N1}=H2,
  [{C1,N+N1}]++join(T1,T2).

split([],_)->[];
split(List,Length)->
  S1=string:substr(List,1,Length),
  case length(List) > Length of
    true->S2=string:substr(List,Length+1,length(List));
    false->S2=[]
  end,
  [S1]++split(S2,Length).

count(Ch, [],N)->N;
count(Ch, [H|T],N) ->
  case Ch==H of
    true-> count(Ch,T,N+1);
    false -> count(Ch,T,N)
  end.

go(Pid,L)->
  io:fwrite("SpawnedCount: "),
  io:fwrite("~w~n",[Pid]),
  Alph=[$a,$b,$c,$d,$e,$f,$g,$h,$i,$j,$k,$l,$m,$n,$o,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z],
  Result = rgo(Alph,L,[]),
  Pid ! {self(),Result}.

rgo([H|T],L,Result)->
  N=count(H,L,0),
  Result2=Result++[{[H],N}],
  rgo(T,L,Result2);
rgo([],L,Result)->Result.

% Notes
% Create a process that will count each of the split files that do each of the letter count
% each count process will send a message with the resulting list of tuples, how to join
% create a function to join the lists together, spawn that as joiner process and pass
% that id to each of the counter processes, instead of recieveing master id they recieve
% joiner process, joiner responsible for taking each resulting lists and adding together
