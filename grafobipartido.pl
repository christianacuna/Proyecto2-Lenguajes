%maximoSubgrafoBipartito([a,b,c,d],[[a,b],[a,c],[b,c],[b,d],[c,d]],X).

%esBipartito([a,b,c,d],[[a,b],[a,c],[b,c],[b,d],[c,d]],X).

%esGrafoConexo([a,b,c,d],[[a,b],[a,c],[b,c],[b,d],[c,d]],X).

%esGrafoAutoDirigido([a,b,c,d],[[a,b],[a,c],[b,c],[b,d],[c,d]],X).
%X = [[a,b],[a,c],[b,d],[c,d]]

maximoSubgrafoBipartito([],_ListaAristas,[]).
maximoSubgrafoBipartito(_ListaNodos,[],[]).
maximoSubgrafoBipartito(ListaNodos,ListaAristas,Resultado):-!.

esBipartito([],_ListaAristas,false).
esBipartito(_ListaNodos,[],false).
esBipartito(ListaNodos,ListaAristas,Resutlado):- 
	esGrafoConexo(ListaNodos,ListaAristas,EsConexo), 
	(EsConexo -> Resultado = true; Resultado = false).

esGrafoConexo(ListaNodos,ListaAristas,Resultado):- 
	flatten(ListaAristas,ListaNodosDuplicados2), 
	sort(ListaNodosDuplicados2,ListaNodos2), 
	(listaIgual(ListaNodos,ListaNodos2) -> Resultado = true ; Resultado = false).

esGrafoAutoDirigido(ListaNodos,ListaAristas,Resultado):- maplist(subListaDiferentes,ListaAristas).

enterosIgual(Numero,Numero2):- Numero=:=Numero2.

subListaDiferentes([Cabeza|[Cabeza2|_]]):- \+(nodosIguales(Cabeza,Cabeza2)).

nodosIguales(Nodo,Nodo2):- Nodo = Nodo2.

listaIgual(L1, L2) :- maplist(=, L1, L2).

miembro(E,[E|_T]).
miembro(E,[_H|T]):-miembro(E,T).

camino(G,A,B,[A,B]):-miembro([A,B],G).
camino(G,_A,_B,Camino):- 
camino(G,A,B,[A|Camino]):-camino(G,C,B,Camino),miembro([A,C],G),\+ miembro(A,Camino).

esCaminoValido(G,[A,B]):-miembro([A,B],G).
esCaminoValido(G,[A,B|Cam]):- 
            miembro([A,B],G), esCaminoValido(G,[B|Cam]).
