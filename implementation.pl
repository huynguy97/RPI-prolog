% node(conflict_set, path, predecessor)

checkSingleHSet(_, []).
checkSingleHSet( [Head | Tail] , List):-
    member(Head, List);
    checkSingleHSet(Tail, List).

checkHSets(_, []).
checkHSets(A, [B | C]):-
    checkSingleHSet(A, B),
    checkHSets(A, C).

labelNode( CS , node(A,B,C), Return ):- % label existing node with CS
    append(A, CS, T),
    Return = node(T, B, C).

createNode(CS, Path, Papa, CreatedNode):- % create a new node.
    CreatedNode = node(CS, Path, Papa).

createChildren( node([], _, _), OldChildren, NewChildren):- 
    append(OldChildren, [], New),
    NewChildren = New.
createChildren( node([ A | B ], Path, Papa), OldChildren, NewChildren):-
    append(Path, [A], NewPath),
    createNode([], NewPath, node([ A | B ], Path, Papa) , CreatedNode),
    append(OldChildren, [CreatedNode], TempChildren),
    createChildren( node( B, Path, Papa), TempChildren, TempTempChildren),
    NewChildren = TempTempChildren.

extractPath(node(_, Path,_), NewPath):-
    NewPath = Path.
% 1. Pick random cs as start for node. In this case A. 
% 2. Check path for hitting set, if hs, mark else label with conflict set. 
% 3. Return
%  Confict sets en Tree als een lijst. [ [x1,x2], [x1,a2,o1] ]
makeHittingTree([], _).
makeHittingTree( [ A | B ] , Tree):-
    createNode(A, [], emptySet, StartingNode),
    createChildren(StartingNode, [], [FirstChild | Rest] ),
    extractPath(FirstChild, Path),
    checkHsets(Path, [A|B]). % branchen hier?
    
    
