-module(lastlist).

-export([noTailNth/2]).
-export([tailNth/2]).

noTailNth(List, N) ->
	noTailRev(lists:reverse(List), N).

noTailRev([], _) ->
	[];

noTailRev(_, N) when N == 0->
	[]; 

noTailRev([H|T], N) when N > 0 ->
	noTailRev(T, N-1) ++ [H].

tailNth(List, N) ->
	tailRev(lists:reverse(List), N, []).

tailRev(_, 0, Accu) ->
	Accu;
tailRev([], _, Accu) ->
	Accu;
tailRev([H|T], N, Accu) ->
	tailRev(T, N-1, [H] ++ Accu).

	


