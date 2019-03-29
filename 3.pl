/**/

member(A, A).
member(X, [X|_]).
member(X, [_|Y]):-
	member(X,Y).

our_subset([], [Set|RestSet]).
our_subset([Sub|RestSub],[Set|RestSet]):-
	member(Sub, [Set|RestSet]),
	our_subset(RestSub, [Set|RestSet]).

path(From, From, _, Visited, Path):-
	append(Visited, [From],List),
	Path = List.
path(From, To, [edge(A,B) | Edges], Visited, Path):-
	member(edge(X,Y),[edge(A,B)|Edges]),
	not(member(Y,Visited)),
	append(Visited, [X], NewVisited),
	path(B,To, Edges, NewVisited, Path).

