/*Assignment 2: KnightsPath*/




/*Checks to see if a jump from point X1/Y1 to X2/Y2 is a valid move for a knight to make 
(2 squares horizontally, 1 square vertically OR 1 square horizontally and 2 squares vertically)*/

jump_checker(X1/Y1,X2/Y2) :- valid_jump_checker(X1),valid_jump_checker(X2),valid_jump_checker(Y1), valid_jump_checker(Y2),
                            (X2 is X1 - 1, Y2 is Y1 + 2; X2 is X1 - 1, Y2 is Y1 - 2;
		                     X2 is X1 + 1, Y2 is Y1 + 2; X2 is X1 + 1, Y2 is Y1 - 2;
		                     X2 is X1 - 2, Y2 is Y1 + 1; X2 is X1 - 2, Y2 is Y1 - 1;
		                     X2 is X1 + 2, Y2 is Y1 + 1; X2 is X1 + 2, Y2 is Y1 - 1).



/*Ensure jump is valid in terms of the chess board. if a movement brings a piece to anything past 8 (doesn't exist) 
on the X or Y axis it will return false, likewise if the move was to bring the piece to a negative square.
(also doesn't exist)*/

valid_jump_checker(Coordinate) :- between(1, 8, Coordinate).



/*Reads in list of co-ordinates and checks these co-ordinates to see if the movement from one point(X1/Y1) to 
another point(X2/Y2) is valid, using the jump_checker predicate i have defined above. I use recursion here
to move on the next element in the list given in the terminal*/

knightpath([X1/Y1|[X2/Y2|[]]]) :- jump_checker(X1/Y1,X2/Y2). /* <---base case*/
knightpath([X1/Y1|[X2/Y2|Tail]]) :- jump_checker(X1/Y1,X2/Y2),
                                    knightpath([X2/Y2|Tail]). 
 


/*Ensures that the element given at position Start is the first element in list Path*/

start_element(X/Y,[X/Y|_]).



/*Ensures that the element given at position End is the final element in list Path*/

end_element(X/Y, [X/Y]).
end_element(X/Y, [_|Z]) :- end_element(X/Y, Z).



/*Knightjourney takes the first and last co-ordinate of the list Path, the length of Path, and the list Path itself 
and returns true if all of these elements are valid parts of the list Path*/

knightjourney(Start, End, L, Path) :- start_element(Start, Path), 
                                      end_element(End, Path), 
                                      length(Path, L), !,
                                      knightpath(Path).



/*Checks to see if the element given in the place of Sq is the Nth element in the list Path*/

position_check([Head|_], Head, 1).
position_check([_|Tail], Sq1, N1) :- N1 > 1, Var is N1 -1, position_check(Tail, Sq1, Var).



/*Checks using position_check predicate if the element given in place of Sq is the element at position N in the list
Path*/

knightpassthru(Path, Sq, N) :- position_check(Path, Sq, N).
