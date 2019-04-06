:- [diagnosis].

% Created by Huy Nguyen s4791916, Jeroen Wijenbergh s4792459
% Usage: "problem1(SD, COMP, OBS), main(SD, COMP, OBS, Output)."

% Create children for a node.
createChildren(node(_,_,_), [], []).
createChildren(node(CS, Path, Predecessor), [A | B], Children) :-
    append(Path, [A], NewPath),
    CreatedNode = node([], NewPath, node(CS, Path, Predecessor)),
    createChildren(node(CS,Path,Predecessor), B, NewChildren),
    append([CreatedNode], NewChildren, Children).

% Make hitting tree for a problem.
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
    makeHittingTree(SD, COMP, OBS, OtherNodes, NewTree), 
    append([leaf(Path, Predecessor)], NewTree, Tree). 

% Gather diagnoses for a tree.
gatherDiagnoses([], []). 
gatherDiagnoses([FirstElement | RestTree] , Diagnoses) :-
	FirstElement = leaf(X,_),
    gatherDiagnoses(RestTree, NewDiagnoses),
    append([X], NewDiagnoses, Diagnoses).
gatherDiagnoses([FirstElement | RestTree], Diagnoses) :-
    not(FirstElement = leaf(_, _)),
    gatherDiagnoses(RestTree, Diagnoses).	

% Gather minimal diagnoses on a ordered list of lists by removing supersets.
% Credit: https://stackoverflow.com/questions/13733496/prolog-removing-supersets-in-a-list-of-lists
gatherMinimalDiagnosesSorted([], []).
gatherMinimalDiagnosesSorted([FirstElement | Rest], Output) :-
    (   select(T, Rest, L1), 
        ord_subset(FirstElement, T)  
    ->  gatherMinimalDiagnoses([FirstElement|L1], Output) 
    ;   Output = [FirstElement|L2],
        gatherMinimalDiagnoses(Rest, L2)
    ).

% Sort the list of lists by making it an ordered list of lists.
sortListofLists([], []).
sortListofLists([ A | B ], SortedList) :-
	sortListofLists(B, NewSortedLists),
	sort(A, Sorted),
	append([Sorted], NewSortedLists, SortedList).

% Gather minimal diagnoses by first ordering the diagnoses and then removing supersets.
gatherMinimalDiagnoses(Diagnoses, Output) :-
    sortListofLists(Diagnoses, SortedDiagnoses),
    gatherMinimalDiagnosesSorted(SortedDiagnoses, Output).

% Get the minimal diagnoses for a problem by:
% Make the hitting tree.
% Get the diagnoses by getting the path of all leaves.
% Extract the minimal diagnoses by removing supersets.
main(SD, COMP, OBS, MinimalDiagnoses) :-
    makeHittingTree(SD, COMP, OBS, HittingTree),
    gatherDiagnoses(HittingTree, Diagnoses),
    gatherMinimalDiagnoses(Diagnoses, MinimalDiagnoses).
