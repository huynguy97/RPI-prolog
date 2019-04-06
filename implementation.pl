% node(conflict_set, path, predecessor)
:- [diagnosis].

createChildren(node(_,_,_), [], []).
createChildren(node(CS, Path, Predecessor), [A | B], Children) :-
    append(Path, [A], NewPath),
    CreatedNode = node([], NewPath, node(CS, Path, Predecessor)),
    createChildren(node(CS,Path,Predecessor), B, NewChildren),
    append([CreatedNode], NewChildren, Children).

makeHittingTree(SD, COMP, OBS, Tree) :-
    makeHittingTree(SD, COMP, OBS, [node([],[],[])], Tree).
makeHittingTree(_, _, _, [], []).
makeHittingTree(SD, COMP, OBS, [node(_, Path, Predecessor) | OtherNodes], Tree) :-
    tp(SD, COMP, OBS, Path, CS),
    createChildren(node(CS, Path, Predecessor), CS, Children), 
    append(OtherNodes, Children, NewNodes),
    makeHittingTree(SD, COMP, OBS, NewNodes, NewTree),
    append([node(CS, Path, Predecessor)], NewTree, Tree).
makeHittingTree(SD, COMP, OBS, [node(_, Path, Predecessor) | OtherNodes], Tree) :-
    not(tp(SD, COMP, OBS, Path, _)),
    makeHittingTree(SD, COMP, OBS, OtherNodes, NewTree), % continue with the rest of the nodes.
    append([leaf(Path, Predecessor)], NewTree, Tree). % leaf doesn't have CS because it is always empty

gatherDiagnoses([], []). % Give a tree, which is a list, and return a list of diagnoses.
gatherDiagnoses([FirstElement | RestTree] , Diagnoses) :-
	FirstElement = leaf(X,_),
    gatherDiagnoses(RestTree, NewDiagnoses),
    append([X], NewDiagnoses, Diagnoses).
gatherDiagnoses([FirstElement | RestTree], Diagnoses) :-
    not(FirstElement = leaf(_, _)),
    gatherDiagnoses(RestTree, Diagnoses).	
