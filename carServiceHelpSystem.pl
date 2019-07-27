% Directives
:- dynamic fact(1).
:- dynamic p/2.
:- dynamic p/3.

% Operator definitions for forward chaining if-then rules:
:- op(800,fx,if).
:- op(700,xfx,then).
:- op(300,xfy,or).
:- op(200,xfy,and).

% Define the Bayesian network graph using the syntax required 
% by Bratko's Bayesian network interpreter:
parent(o, tp).
parent(o, nm).
parent(ew, nm).
parent(ew, br).
parent(db, br).
parent(bo, tp).
parent(bo, nc).
parent(tp, sm).
parent(nm, s).
parent(br, s).
parent(br, tr).
parent(nc, bs).
parent(nm, bs).

% Define the Bayesian network prior probabilities:
p(o, 0.10).
p(ew, 0.22).
p(db, 0.5).
p(bo, 0.3).

% Define Bayesian network conditional probability tables:
p( tp, [ o], 0.4).
p( tp, [ not(o)], 0.2).
p( nm, [ o, ew ], 0.6).
p( nm, [ not(o), ew ], 0.33).
p( nm, [ o, not(ew) ], 0.2).
p( nm, [ not(o), not(ew) ], 0.02).
p( br, [ ew, db ], 0.7).
p( br, [ not(ew), db ], 0.65).
p( br, [ ew, not(db) ], 0.35).
p( br, [ not(ew), not(db) ], 0.3).
p( sm, [ tp ], 0.55).
p( sm, [ not(tp) ], 0.45).
p( nc, [bo], 0.7).
p( nc, [not(bo)], 0.1).
p( s, [ nm, br ], 0.36).
p( s, [ not(nm), br ], 0.68).
p( s, [ nm, not(br) ], 0.32).
p( s, [ not(nm), not(br) ], 0.14).
p( tr, [ br ], 0.45).
p( tr, [ not(br) ], 0.02).
p( bs, [ tp, nc ], 0.4).
p( bs, [ not(tp), nc ], 0.4).
p( bs, [ tp, not(nc) ], 0.33).
p( bs, [ not(tp), not(nc) ], 0.2).

% Define forward chaining rules:
if tp and y then go_to_specialist.
if tp and y then get_engine_analysis.
if tp and y then fix_engine.

if tp and n then go_to_retailer.
if tp and n then get_engine_analysis.
if tp and n then go_to_specialist.

if nm and y then go_to_retailer.
if nm and y then buy_new_motor.
if nm and y then replace_motor.

if nm and n then go_to_car_shop.
if nm and n then recieve_motor_tuneup.
if nm and n then hope_for_the_best.

if br and y then call_triple_A.
if br and y then have_them_jumpstart_car.
if br and y then hope_that_works.

if br and n then go_to_auto_repair_store.
if br and n then find_suitable_battery.
if br and n then replace_battery.

if nc and y then go_to_auto_repair_store.
if nc and y then check_engine_levels.
if nc and y then buy_suitable_parts.

if nc and n then go_to_cheap_oil_replacer.
if nc and n then get_oil_replaced.
if nc and n then get_tires_rotated.

% Implement the main program:
start:- go, forward.

go :- write('Do you have an old motor? (y or n):'), read(A), nl, 
	write('Do you have extreme weather in your area? (y or n):'), 
	read(B), nl, write('Is your battery dead? (y or n):'),
	read(C), nl, write('Have you checked your oil status recently? (y or n):'), 
	read(D), nl, pro(A, B, C, D).

pro(y,y,y,y) :- write('Probability of Engine Tune-Up: '), 
	prob(tp, [o, ew, db, bo], M), assert(prob(tp,M)), write(M), nl, 
	write('Probability of New Motor: '), prob(nm, [o, ew, db, bo], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [o, ew, db, bo], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [o, ew, db, bo], P), assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(y,y,y,n) :- write('Probability of Engine Tune-Up: '), 
	prob(tp, [o, ew, db, not(bo)], M), assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), 
	prob(nm, [o, ew, db, not(bo)], N), assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [o, ew, db, not(bo)], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [o, ew, db, not(bo)], P), assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(y,y,n,y) :- write('Probability of Engine Tune-Up: '), prob(tp, [o, ew, not(db), bo], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), 
	prob(nm, [o, ew, not(db), bo], N), assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [o, ew, not(db), bo], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [o, ew, not(db), bo], P), assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(y,y,n,n) :- write('Probability of Engine Tune-Up: '), prob(tp, [o, ew, not(db), not(bo)], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [o, ew, not(db), not(bo)], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [o, ew, not(db), not(bo)], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [o, ew, not(db), not(bo)], P), assert(prob(nc,P)), write(P), max(M,N,O,P).

pro(y,n,y,y) :- write('Probability of Engine Tune-Up: '), prob(tp, [o, not(ew), db, bo], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), 
	prob(nm, [o, not(ew), db, bo], N), assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [o, not(ew), db, bo], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [o, not(ew), db, bo], P), assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(y,n,y,n) :- write('Probability of Engine Tune-Up: '), prob(tp, [o, not(ew), db, not(bo)], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [o, not(ew), db, not(bo)], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [o, not(ew), db, not(bo)], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [o, not(ew), db, not(bo)], P), assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(y,n,n,y) :- write('Probability of Engine Tune-Up: '), prob(tp, [o, not(ew), not(db), bo], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [o, not(ew), not(db), bo], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [o, not(ew), not(db), bo], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [o, not(ew), not(db), bo], P), assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(y,n,n,n) :- write('Probability of Engine Tune-Up: '), prob(tp, [o, not(ew), not(db), not(bo)], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [o, not(ew), not(db), not(bo)], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [o, not(ew), not(db), not(bo)], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [o, not(ew), not(db), not(bo)], P), assert(prob(nc,P)), write(P), max(M,N,O,P).

pro(n,y,y,y) :- write('Probability of Engine Tune-Up: '), prob(tp, [not(o), ew, db, bo], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [not(o), ew, db, bo], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), prob(br, [not(o), ew, db, bo], O), 
	assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), prob(nc, [not(o), ew, db, bo], P), 
	assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(n,y,y,n) :- write('Probability of Engine Tune-Up: '), prob(tp, [not(o), ew, db, not(bo)], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [not(o), ew, db, not(bo)], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [not(o), ew, db, not(bo)], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [not(o), ew, db, not(bo)], P), assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(n,y,n,y) :- write('Probability of Engine Tune-Up: '), prob(tp, [not(o), ew, not(db), bo], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [not(o), ew, not(db), bo], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [not(o), ew, not(db), bo], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [not(o), ew, not(db), bo], P), assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(n,y,n,n) :- write('Probability of Engine Tune-Up: '), prob(tp, [not(o), ew, not(db), not(bo)], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [not(o), ew, not(db), not(bo)], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), 
	prob(br, [not(o), ew, not(db), not(bo)], O), assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), 
	prob(nc, [not(o), ew, not(db), not(bo)], P), assert(prob(nc,P)), write(P), max(M,N,O,P).

pro(n,n,y,y) :- write('Probability of Engine Tune-Up: '), prob(tp, [not(o), not(ew), db, bo], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [not(o), not(ew), db, bo], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), prob(br, [not(o), not(ew), db, bo], O), 
	assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), prob(nc, [not(o), not(ew), db, bo], P), 
	assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(n,n,y,n) :- write('Probability of Engine Tune-Up: '), prob(tp, [not(o), not(ew), db, not(bo)], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [not(o), not(ew), db, not(bo)], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), prob(br, [not(o), not(ew), db, not(bo)], O), 
	assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), prob(nc, [not(o), not(ew), db, not(bo)], P), 
	assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(n,n,n,y) :- write('Probability of Engine Tune-Up: '), prob(tp, [not(o), not(ew), not(db), bo], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [not(o), not(ew), not(db), bo], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), prob(br, [not(o), not(ew), not(db), bo], O), 
	assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), prob(nc, [not(o), not(ew), not(db), bo], P), 
	assert(prob(nc,P)), write(P), max(M,N,O,P).
	
pro(n,n,n,n) :- write('Probability of Engine Tune-Up: '), prob(tp, [not(o), not(ew), not(db), not(bo)], M), 
	assert(prob(tp,M)), write(M), nl, write('Probability of New Motor: '), prob(nm, [not(o), not(ew), not(db), not(bo)], N), 
	assert(prob(nm,N)), write(N), nl, write('Probability of Battery Replacement: '), prob(br, [not(o), not(ew), not(db), not(bo)], O), 
	assert(prob(br,O)), write(O), nl, write('Probability of Oil Change: '), prob(nc, [not(o), not(ew), not(db), not(bo)], P), 
	assert(prob(nc,P)), write(P), max(M,N,O,P).

max(M,N,O,P) :- M >= N, M >= O, M >= P, nl, write('The likeliest issue is '), lookup(M).

max(M,N,O,P) :- N >= M, N >= O, N >= P, nl, write('The likeliest issue is '), lookup(N).

max(M,N,O,P) :- O >= N, O >= M, O >= P, nl, write('The likeliest issue is '), lookup(O).

max(M,N,O,P) :- P >= N, P >= O, P >= M, nl, write('The likeliest issue is '), lookup(P).
 
lookup(X) :- prob(Y, X), solved(Y).

solved(tp) :- write('your engine needs a Tuneup! '), nl, assert(fact(tp)), 
	write('Have you gotten your engine tuned in the past 6 months?'), read(X), assert(fact(X)). 

solved(nm) :- write('you may need a new motor. '), nl, assert(fact(nm)), 
	write('Do you have the funds to buy a new motor?'), read(X), assert(fact(X)). 

solved(br) :- write('your battery needs recharging! '), nl, assert(fact(br)), 
	write('Have you tried jumping your car?'), read(X), assert(fact(X)). 		   

solved(nc) :- write('you may need to change your oil. '), nl, assert(fact(nc)), 
	write('Have you changed your oil in the past 8 months?'), read(X), assert(fact(X)). 