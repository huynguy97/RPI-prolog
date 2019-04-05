% node(conflict_set, path, predecessor)
:- [diagnosis].

checkSingleHSet(_, []).
checkSingleHSet( [Head | Tail] , List):-
    member(Head, List);
    checkSingleHSet(Tail, List).

checkHSets(_, []).
checkHSets(A, [B | C]):-
    checkSingleHSet(A, B),
    checkHSets(A, C).

createNode(CS, Path, Papa, CreatedNode) :- % create a new node.
    CreatedNode = node(CS, Path, Papa).

createChildren(node(_,_,_), [], []).
createChildren(node(CS, Path, Predecessor), [A | B], Children) :-
    append(Path, [A], NewPath),
    createNode([], NewPath, node(CS, Path, Predecessor), CreatedNode),
    createChildren(node(CS,Path,Predecessor), B, NewChildren),
    append([CreatedNode], NewChildren, Children).

makeHittingTree(SD, COMP, OBS, Tree) :-
    makeHittingTree(SD, COMP, OBS, [node([],[],[])], Tree).
makeHittingTree(_, _, _, [], []).
makeHittingTree(SD, COMP, OBS, [node(CS, Path, Predecessor) | OtherNodes], Tree) :-
    not(tp(SD, COMP, OBS, Path, _)),
    makeHittingTree(SD, COMP, OBS, OtherNodes, NewTree), % continue with the rest of the nodes.
    append([leaf(Path, Predecessor)], NewTree, Tree). % leaf doesn't have CS because it is always empty
makeHittingTree(SD, COMP, OBS, [node(_, Path, Predecessor) | OtherNodes], Tree) :-
    tp(SD, COMP, OBS, Path, CS),
    createChildren(node(CS, Path, Predecessor), CS, Children), 
    append(OtherNodes, Children, NewNodes),
    makeHittingTree(SD, COMP, OBS, NewNodes, NewTree),
    append([node(CS, Path, Predecessor)], NewTree, Tree).


    
     
     
