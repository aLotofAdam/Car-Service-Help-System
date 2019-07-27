% Figure 15.11  An interpreter for belief networks.

prob( [X | Xs], Cond, P)  :-  !,   % Probability of conjunction
  prob( X, Cond, Px),
  prob( Xs, [X | Cond], PRest),
  P is Px * PRest.

prob( [], _, 1)  :-  !.            % Empty conjunction

prob( X, Cond, 1)  :-
  mymember( X, Cond), !.             % Cond implies X

prob( X, Cond, 0)  :-
  mymember( not(X), Cond), !.         % Cond implies X is false

prob( not(X), Cond, P)  :-  !,      % Probability of negation
  prob( X, Cond, P0),
  P is 1 - P0.

% Use Bayes rule if condition involves a descendant of X

prob( X, Cond0, P)  :-
  mydelete( Y, Cond0, Cond),
  predecessor( X, Y), !,           % Y is a descendant of X
  prob( X, Cond, Px),
  prob( Y, [X | Cond], PyGivenX),
  prob( Y, Cond, Py),              
  P is Px * PyGivenX / Py.         % Assuming Py > 0

% Cases when condition does not involve a descendant

prob( X, Cond, P)  :-
  p( X, P), !.              % X a root cause - its probability given

prob( X, Cond, P)  :-  !,
  findall( (CONDi,Pi), p(X,CONDi,Pi), CPlist),  % Conditions on parents
  sum_probs( CPlist, Cond, P).

% sum_probs( CondsProbs, Cond, WeigthedSum)
%   CondsProbs is a list of conditions and corresponding probabilities,
%   WeightedSum is weighted sum of probabilities of Conds given Cond

sum_probs( [], _, 0).

sum_probs( [ (COND1,P1) | CondsProbs], COND, P)  :-
  prob( COND1, COND, PC1),
  sum_probs( CondsProbs, COND, PRest),
  P is P1 * PC1 + PRest.

predecessor( X, not(Y))  :- !,        % Negated variable Y
  predecessor( X, Y).

predecessor( X, Y)  :-
  parent( X, Y).

predecessor( X, Z)  :-
  parent( X, Y),
  predecessor( Y, Z).

mymember( X, [X | _]).

mymember( X, [_ | L])  :-
  mymember( X, L).

mydelete( X, [X | L], L).

mydelete( X, [Y | L], [Y | L2])  :-
  mydelete( X, L, L2).
