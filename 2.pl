isBinaryTree(leaf).
isBinaryTree(node(X, Y)) :-
    isBinaryTree(X),
    isBinaryTree(Y).

nnodes(leaf, N) :-
    N = 1.
nnodes(node(X,Y), N) :-
    nnodes(X, Res1),
    nnodes(Y,Res2),
    N is 1 + Res1 + Res2.

