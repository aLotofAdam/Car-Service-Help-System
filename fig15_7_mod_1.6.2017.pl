% Figure 15.7  A forward chaining rule interpreter.
% Modifications: changed use of "not" to require parentheses
% (otherwise fails to compile).
% How to use
% Warning: before loading this, load a file with the operator
% definitions for if/then/and/or
% To use the interpreter, first load a file of rules, e.g.,
%     if snowing then cold.
% Then assert some facts, e.g., fact(snowing).
% Then to forward chain on rules, type query 'forward'.

% Simple forward chaining in Prolog

forward  :-
   new_derived_fact( P),             % A new fact   
   !,
   write( 'Derived: '), write( P), nl,
   assert( fact( P)),
   forward                           % Continue   
   ;
   write( 'No more facts').          % All facts derived

new_derived_fact( Concl)  :-
   if Cond then Concl,               % A rule   
   not( fact( Concl) ),              % Rule's conclusion not yet a fact
   composed_fact( Cond).             % Condition true? 

composed_fact( Cond)  :-
   fact( Cond).                      % Simple fact 

composed_fact( Cond1 and Cond2)  :-
   composed_fact( Cond1),
   composed_fact( Cond2).            % Both conjuncts true 

composed_fact( Cond1 or Cond2)  :-
   composed_fact( Cond1)
   ;
   composed_fact( Cond2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fix for not added 1/06/2017:
composed_fact(not(Cond)) :- not(fact(Cond)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


