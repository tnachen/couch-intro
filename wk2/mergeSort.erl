-module(mergeSort).

-export([mergeSort/1]).

mergeRec(L1, []) -> L1;
mergeRec([], L2) -> L2;

mergeRec([H1|T1], [H2|T2]) ->
	if
		H1 > H2 ->
			[H2|mergeRec(T2, [H1|T1])];
		true ->
			[H1|mergeRec(T1, [H2|T2])]
    end.

mergeSort(List) when length(List) =< 1 -> List;
mergeSort(List) ->
	{A, B} = lists:split(length(List) div 2, List),
    mergeRec(mergeSort(A), mergeSort(B)).
