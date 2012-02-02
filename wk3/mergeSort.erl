-module(mergeSort).

-export([mergeSortPar/1,mergeSort2/0]).

mergeRec(L1, []) -> L1;
mergeRec([], L2) -> L2;

mergeRec([H1|T1], [H2|T2]) ->
	if
		H1 > H2 ->
			[H2|mergeRec(T2, [H1|T1])];
		true ->
			[H1|mergeRec(T1, [H2|T2])]
    end.

mergeSplit(List) when length(List) =< 1 -> List;
mergeSplit(List) ->
	{A, B} = lists:split(length(List) div 2, List),
	mergeRec(mergeSplit(A), mergeSplit(B)).

mergeSort2() ->
	receive
		{From, List} ->  
			From ! {self(), mergeSplit(List)};
		terminate  ->
			ok
    end.

mergeSortPar(List) when length(List) =< 1 ->
	List;
mergeSortPar(List) ->
	{A, B} = lists:split(length(List) div 2, List),
	APid = spawn(mergeSort, mergeSort2, []),
	BPid = spawn(mergeSort, mergeSort2, []),
	APid ! {self(), A},
	BPid ! {self(), B},
	receive
		{APid, SortedA} -> ok
    end,
	receive
		{BPid, SortedB} -> ok
    end,
	mergeRec(SortedA, SortedB).
			
-include_lib("eunit/include/eunit.hrl").

merge_test() ->
	random_list_test(50000),
	random_list_test(100000),
	random_list_test(1000000).
random_list_test(N) -> 
	List = [random:uniform(100) || _ <- lists:seq(1,N)],
	A = now(),
	mergeSortPar(List),
	B = now(),
	ParTime = timer:now_diff(B,A) / 1000,
	io:format("Parallel time for ~p list: ~p~n", [N, ParTime]),
	ListB = [random:uniform(100) || _ <- lists:seq(1,N)],
	C = now(),
	mergeSplit(ListB),
	D = now(),
	SerTime = timer:now_diff(D,C) / 1000,
	io:format("Serial time for ~p list: ~p~n", [N, SerTime]).

	

	

