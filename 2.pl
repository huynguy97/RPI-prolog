/**/
isBinaryTree(leaf(_)).
isBinaryTree(node((X,A),(Y,B))) :-
    isBinaryTree((X,A)),
    isBinaryTree((Y,B)).

nnodes(leaf(_), N) :-
    N = 1.
nnodes(node((X,A), (Y,B)), N) :-
    nnodes( (X,A) , Res1),
    nnodes( (Y,B) , Res2),
    N is 1 + Res1 + Res2.

makeBinary(N, Tree) :-
    N = 0,
    Tree = leaf(N).
makeBinary(N, Tree) :-
    N > 0,
    NewN is N-1,
    makeBinary(NewN, R1),
    Tree = node(R1, R1, N).

makeTree(N, _, Tree) :-
    N = 0,
    Tree = leaf.
makeTree(N, NumberOfChildren, Tree) :-
    N > 0,
    NewN is N-1,
    makeTree(NewN, NumberOfChildren, R1),
    createLayer(R1, NumberOfChildren, R2),
    Tree = node(R2).

createLayer(_, N, Result) :-
    N = 0,
    Result = [].

createLayer(A, N, Result) :-
    N > 0,
    NewN is N-1,
    createLayer(A, NewN, TempResult),
    append([A], TempResult, Result).
