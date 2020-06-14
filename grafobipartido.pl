%maximoSubgrafoBipartito([a,b,c,d],[[a,b],[a,c],[b,c],[b,d],[c,d]],X).

maximoSubgrafoBipartito([],_ListaAristas,[]).
maximoSubgrafoBipartito(_ListaNodos,[],[]).
maximoSubgrafoBipartito(_ListaNodos,ListaAristas,Resultado):-crearGrafosConListaArista(ListaAristas,Resultado).

checkeoLogico(N,L,R):- member(N,L) -> R = true; R = false.

accRev([H|T],A,R):- accRev(T,[H|A],R).
accRev([],A,A).

rev(L,R):- accRev(L,[],R).

%Nodos no existen en los grafos entonces se agregan.
compuertaLogica(false,false,false,false,N1,N2,L1,L2,NL1,NL2,Bandera):- append(L1,[N1],NL1), append(L2,[N2],NL2),Bandera = false.

%Nodos si existen en los grafos e invalidan requerimiento bipartido.
compuertaLogica(true,true,true,true,_N1,_N2,L1,L2,L1,L2,Bandera):- Bandera = true.
compuertaLogica(true,false,true,false,_N1,_N2,L1,L2,L1,L2,Bandera):- Bandera = true.
compuertaLogica(false,true,false,true,_N1,_N2,L1,L2,L1,L2,Bandera):- Bandera = true.

%Nodos si existen en los grafos pero no invalidan requerimiento bipartido.
compuertaLogica(true,false,false,true,_N1,_N2,L1,L2,L1,L2,Bandera):- Bandera = false.
compuertaLogica(false,true,true,false,_N1,_N2,L1,L2,L1,L2,Bandera):- Bandera = false.

%Nodo1 si existe en los grafos, se inserta Nodo2 en el otro grafo.
compuertaLogica(true,false,false,false,_N1,N2,L1,L2,L1,NL2,false):- append(L2,[N2],NL2).
compuertaLogica(false,true,false,false,_N1,N2,L1,L2,NL1,L2,false):- append(L1,[N2],NL1).

%Nodo2 si existe en los grafos, se inserta Nodo1 en el otro grafo.
compuertaLogica(false,false,true,false,N1,_N2,L1,L2,L1,NL2,false):- append(L2,[N1],NL2).
compuertaLogica(false,false,false,true,N1,_N2,L1,L2,NL1,L2,false):- append(L1,[N1],NL1).

% insertarUnicoEnGrafos([a,b],[],[],NG1,NG2,R).
insertarUnicoEnGrafos([N1|[N2|_]],G1,G2,NG1,NG2,R):- %write('New'),
	checkeoLogico(N1,G1,R1),%write(R1),
	checkeoLogico(N1,G2,R2),%write(R2),
	checkeoLogico(N2,G1,R3),%write(R3),
	checkeoLogico(N2,G2,R4),%write(R4),
	compuertaLogica(R1,R2,R3,R4,N1,N2,G1,G2,NG1,NG2,R),!. %print(NG1) , print(NG2),write(R),print('\n'),!.

%Cambiar esta lina en caso de usar Backtracking.
%crearGrafosConListaAristaAux(_,_Grafo1,_Grafo2,[]).
crearGrafosConListaAristaAux([],_Grafo1,_Grafo2,[]).
crearGrafosConListaAristaAux([Cabeza|Cola],Grafo1,Grafo2,NewListaArista):-
	%print(Cola),print('\n'),
	insertarUnicoEnGrafos(Cabeza,Grafo1,Grafo2,NewGrafo1,NewGrafo2,Bandera),
	(\+Bandera-> 
		(crearGrafosConListaAristaAux(Cola,NewGrafo1,NewGrafo2,NLA), append([Cabeza],NLA,NewListaArista)) ;
		(\+(NewListaArista = _) -> (crearGrafosConListaAristaAux(Cola,NewGrafo1,NewGrafo2,[]));
			(crearGrafosConListaAristaAux(Cola,NewGrafo1,NewGrafo2,NewListaArista)))).
		
% append([Cabeza],NewListaArista,NLA)
%crearGrafosConListaArista([[a,b],[a,c],[b,c],[b,d],[c,d]],L).

crearGrafosConListaArista([],[]).
crearGrafosConListaArista(ListaArista,NewListaArista):- crearGrafosConListaAristaAux(ListaArista,[],[],NewListaArista).
