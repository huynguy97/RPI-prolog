isBinaryTree(leaf).
isBinaryTree(node(X, Y)) :-
    isBinaryTree(X),
    isBinaryTree(Y).


