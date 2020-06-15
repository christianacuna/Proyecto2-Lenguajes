% diametro([a,b,c,d],[[a,b],[a,c],[b,c],[b,d],[c,d]],X).





diametro(_Nodos,Aristas,R):-diametroAux(Aristas,R).
diametroAux([Cabeza|Cola],R):- diametroAuxAux(Cabeza,Cola,R).

diametroAuxAux(Elemento,Aristas,R):- diametroAuxAuxAux(Elemento,Aristas,R,Aristas).

diametroAuxAuxAux(Elemento,Aristas,R,[Cabeza|[Cabe|Cola]]):-
print(Elemento),print('\n'),print(Aristas),
obtenerDiametro(Elemento,Aristas,R);diametroAuxAuxAux(Cabe,Aristas,R,Cola).

obtenerDiametro([_Cabeza|Cola],[],Cola).
obtenerDiametro([Cabeza|[Cc1|_Cola]],[[Cabeza2|[Cc2|_Sobrante]]|Cola2],R):-(Cc1 = Cabeza2 -> 
	obtenerDiametro([Cabeza2,Cc2],Cola2,R2),R = [Cabeza|R2];(obtenerDiametro([Cabeza,Cc1],Cola2,R))).


combinaciones(_,0,[]).
combinaciones([Cabeza|Cola],Numero,[Cabeza|Cola2]):-Numero>0, N1 is Numero-1, combinaciones(Cola,N1,Cola2).
combinaciones([_|Cola],Numero,Lista):-Numero>0, combinaciones(Cola,Numero,Lista).
