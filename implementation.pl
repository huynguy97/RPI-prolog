/**/
checkSingleHSet(_, []).
checkSingleHSet( [Head | Tail] , List):-
    member(Head, List);
    checkSingleHSet(Tail, List).

checkHSets(_, []).
checkHSets(A, [B | C]):-
    checkSingleHSet(A, B),
    checkHSets(A, C).

labelNode( CS , node(A,B,C), Return ):-
    append(A, CS, T),
    Return = node(T, B, C).

makeHittingTree( [ A | B ] , Tree).
    
