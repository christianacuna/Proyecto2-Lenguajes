%[a,b,c,d], [[a,b],[a,c],[b,c],[b,d],[c,d]]
%[a,b,c,d], [[a,b],[c,d]]
%[a,b,c,d], [[a,b],[a,c],[c,d]]
%[a,b,c,d], [[b,c],[b,d],[c,d]]
%[a,b,c,d], [[a,d],[b,c]]
%[a,b,c,d,e,f], [[a,b],[a,c],[b,c],[b,d],[c,d]]
%[a,b,c,d,e,f], [[a,b],[a,c],[b,c],[b,d],[c,d],[a,e],[a,f]]
%[a,b,c,d,e,f], [[a,b],[a,c],[b,c],[b,d],[c,d],[b,e],[b,f]]
%[a,b,c,d,e,f], [[a,b],[a,c],[b,c],[b,d],[c,d],[c,e],[c,f]]
%[a,b,c,d,e,f], [[a,b],[a,c],[b,c],[b,d],[c,d],[d,e],[d,f]]

combinaciones(_L,0,[]).
combinaciones([H|T],N,[H|C]):-N>0, N1 is N-1, combinaciones(T,N1,C).
combinaciones([_H|T],N,C):-N>0, combinaciones(T,N,C).

vecinosConN(_N,[],[]):-!.
vecinosConN(N,[[N,B]|A],[B|RV]):-vecinosConN(N,A,RV),!.
vecinosConN(N,[[B,N]|A],[B|RV]):-vecinosConN(N,A,RV),!.
vecinosConN(N,[_C|A],RV):-vecinosConN(N,A,RV),!.

verificarClique([N|RN],LA):-vecinosConN(N,LA,VN), verificarCliqueAux(RN,VN).

verificarCliqueAux(RN,VN):-forall(member(E,RN), member(E,VN)).

cliqueMaximo(LN,LA,X):-length(LN,L), L1 is L-1, buscarCliques(LN,LA,L1,X).

buscarCliques(_LN,_LA,1,_X):-!.
buscarCliques(LN,LA,L,C):-(combinaciones(LN,L,C), verificarClique(C,LA)) ; (L1 is L-1, buscarCliques(LN,LA,L1,C)).
