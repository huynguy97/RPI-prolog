isBinaryTree((leaf, N)).
isBinaryTree(node((X,A),(Y,B))) :-
    isBinaryTree((X,A)),
    isBinaryTree((Y,B)).

nnodes( (leaf,A), N) :-
    N = 1.
nnodes(node((X,A), (Y,B)), N) :-
    nnodes( (X,A) , Res1),
    nnodes( (Y,B) ,Res2),
    N is 1 + Res1 + Res2.

makeBinary(X,leaf):-
	X < 1,
	leaf is (leaf,0).
