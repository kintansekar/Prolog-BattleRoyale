/*map*/

area(X, Y, Region) :- X>= 1, X=<4, Y>=1, Y=<5, Region = quarry, !.
area(X, Y, Region) :- X>= 5, X=<9, Y>=1, Y=<5, Region = military_base, !.
area(X, Y, Region) :- X>= 10, X=<15, Y>=1, Y=<7, Region = mylta, !.
area(X, Y, Region) :- X>= 1, X=<5, Y>=6, Y=<11, Region = georgopol, !.
area(X, Y, Region) :- X>= 6, X=<9, Y>=6, Y=<10, Region = pochinki, !.
area(X, Y, Region) :- X>= 10, X=<15, Y>=8, Y=<12, Region = yasnaya, !.
area(X, Y, Region) :- X>= 1, X=<5, Y>=12, Y=<15, Region = zharki, !.
area(X, Y, Region) :- X>= 6, X=<9, Y>=11, Y=<15, Region = severny, !.
area(X, Y, Region) :- X>= 10, X=<15, Y>=13, Y=<15, Region = stalber.

/*Deadzone*/
deadzone_counter:-
  deadzone_timer(T),T==0,!,
  retract(deadzone_timer(T)),asserta(deadzone_timer(8)),
  deadzone_area(X), Xn is X+1, retract(deadzone_area(X)), assertz(deadzone_area(Xn)).
  
 deadzone_counter:-!.
 
 /*Cek apakah move masuk deadzone atau tidak*/
 is_able_move(X,_):-deadzone_area(A),X@=<A,!,fail.
 is_able_move(_,Y):-deadzone_area(A),Y@=<A,!,fail.
 is_able_move(X,_):-deadzone_area(A),Aright is 19-A,X@>=Aright,!,fail.
 is_able_move(_,Y):-deadzone_area(A),Aright is 19-A,Y@>=Aright,!,fail.
 is_able_move(_,_).
 
 /*Enter deadzone*/
 enter_deadzone:-
  player(X,Y,_,_,_,_,_),
  deadzone_area(A),
  (X@=<A; Y@=<A; Aright is 19-A, X@>=Aright; Aright is 19-A, Y@>=Aright),!,
  write('yah cupu lu masuk deadzone'),nl. 
