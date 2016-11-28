-module(unique).
-export([count_unique/1]).
-export([unique/1]).
-export([count/1]).
-export([count_unique_file/1]).

%retuns how many items are in a list
count(List) -> count(List,0).
count([],Length) -> Length;
count([_|T],Length) ->
  count(T,Length+1).

%returns a list of unique items in input list
unique([]) -> [];
unique([H|T]) -> [H] ++ unique([X || X <- T, X /= H]).

%retuns count of the unique items in a list
count_unique(List) ->
  Unique = unique(List),
  io:fwrite("~p~n" , [Unique]),
  io:fwrite("Unique items in list: ", []),
  count(Unique).

count_unique_file(File)->
  {ok, Binary} = file:read_file(File),
  String = binary_to_list(Binary),
  Lowercase = string:to_lower(String), %coverts to lowercase
  %uses regex to remove unneeded punctuation
  List = re:split(Lowercase, "[,\s\n\r!.-?--\\[\\]']", [{return, list}]), % splts each word into a list
  count_unique(List).
