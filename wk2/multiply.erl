-module(multiply).

-export([multiply/2]).

multiply(L1, L2) ->
	Length = min(length(L1), length(L2)),
	lists:zipwith(fun(A, B) -> A * B end, lists:sublist(L1, Length), lists:sublist(L2, Length)).
