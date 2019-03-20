/**/

member(A, A).
member(X, [X|_]).
member(X, [_|Y]):-
	member(X,Y).

our_subset([], [Set|RestSet]).
our_subset([Sub|RestSub],[Set|RestSet]):-
	member(Sub, [Set|RestSet]),
	our_subset(RestSub, [Set|RestSet]).

path(From, From, _, _,)Path):-
	path = [From,From].

path
