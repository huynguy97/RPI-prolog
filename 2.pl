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


makeBinary(N, Tree):-
	N < 0,
	Tree = false.
makeBinary(N,Tree):-
	N = 0,
	Tree = leaf(N).
makeBinary(N, Tree):-
	N > 0,
        NewN is N-1,
        makeBinary(NewN, R1),
        Tree = node(R1, R1, N).
	
makeTree(N, NumberOfChildren, Tree):-
	N=0,
	NumberOfChildren=0,
	Tree = false.
