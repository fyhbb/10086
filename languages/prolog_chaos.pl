% prolog_chaos.pl - family trees, logic puzzles, and questionable life choices
% author: definitely a professional (citation needed)

:- use_module(library(lists)).
:- use_module(library(random)).

% ========== FAMILY TREE (chaotic edition) ==========
% nobody asked for this many relatives but here we are

parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).
parent(liz, sue).
parent(liz, kim).
parent(jim, zoe).
parent(kim, max).
parent(sue, leo).

male(tom).
male(bob).
male(pat).
male(jim).
male(max).
male(leo).

female(liz).
female(ann).
female(sue).
female(kim).
female(zoe).

age(tom, 85).
age(bob, 60).
age(liz, 58).
age(pat, 55).
age(ann, 30).
age(sue, 28).
age(kim, 25).
age(jim, 32).
age(zoe, 5).
age(max, 8).
age(leo, 3).

% ========== RELATIONSHIP RULES ==========

father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
brother(X, Y) :- sibling(X, Y), male(X).
sister(X, Y) :- sibling(X, Y), female(X).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
uncle(X, Y) :- brother(X, Z), parent(Z, Y).
aunt(X, Y) :- sister(X, Z), parent(Z, Y).
cousin(X, Y) :- parent(A, X), parent(B, Y), sibling(A, B), X \= Y.
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% ========== LOGIC PUZZLES ==========

% who is older?
older_than(X, Y) :- age(X, A), age(Y, B), A > B.

% find all descendants of X
descendants(X, List) :- findall(D, ancestor(X, D), List).

% count children
num_children(X, Count) :- findall(C, parent(X, C), Kids), length(Kids, Count).

% ========== MAIN MENU (the fun part) ==========

main :- 
    write('============================='), nl,
    write('   PROLOG CHAOS v0.1'), nl,
    write('   (logic is optional)'), nl,
    write('============================='), nl,
    main_loop.

main_loop :-
    write(''), nl,
    write('1) Find ancestors'), nl,
    write('2) Find descendants'), nl,
    write('3) Who is older?'), nl,
    write('4) Count children'), nl,
    write('5) Family list'), nl,
    write('6) Random fact'), nl,
    write('7) Number game'), nl,
    write('0) Quit'), nl,
    write('Choice: '),
    read(Choice),
    process(Choice).

process(0) :- write('Goodbye! (logic remains unsolved)'), nl, !.
process(1) :- ask_ancestor, main_loop.
process(2) :- ask_descendants, main_loop.
process(3) :- ask_older, main_loop.
process(4) :- ask_children, main_loop.
process(5) :- list_family, main_loop.
process(6) :- random_fact, main_loop.
process(7) :- number_game, main_loop.
process(_) :- write('Invalid choice. Logic says try again.'), nl, main_loop.

ask_ancestor :-
    write('Who to find ancestors for? '),
    read(Name),
    (ancestor(Name, _) ->
        write('Ancestors of '), write(Name), write(':'), nl,
        forall(ancestor(X, Name), write('  - '), write(X), nl)
    ;
        write('No ancestors found (or name is wrong)'), nl
    ).

ask_descendants :-
    write('Who to find descendants for? '),
    read(Name),
    descendants(Name, List),
    (List \= [] ->
        write('Descendants of '), write(Name), write(':'), nl,
        print_list(List)
    ;
        write('None found (tough family tree)'), nl
    ).

ask_older :-
    write('First person: '), read(A),
    write('Second person: '), read(B),
    (age(A, AgeA), age(B, AgeB) ->
        (AgeA > AgeB ->
            write(A), write(' is older ('), write(AgeA), write(' vs '), write(AgeB), write(')'), nl
        ; AgeA < AgeB ->
            write(B), write(' is older ('), write(AgeB), write(' vs '), write(AgeA), write(')'), nl
        ;
            write('Same age! (rare in Prolog)'), nl
        )
    ;
        write('Person not found in database.'), nl
    ).

ask_children :-
    write('Whose children to count? '),
    read(Name),
    num_children(Name, Count),
    write(Name), write(' has '), write(Count), write(' children.'), nl.

list_family :-
    write('All known people:'), nl,
    forall(age(Name, Age),
        (   male(Name) -> write('  [M] ')
        ;   female(Name) -> write('  [F] ')
        ;   write('  [?] ')
        ),
        write(Name), write(' (age '), write(Age), write(')'), nl
    ).

random_fact :-
    random_member(Fact, [
        'Prolog was invented in 1972. Yes, it is older than you.',
        'The name comes from PROgrammation en LOGique.',
        'Prolog does not have loops. It has recursion. Deal with it.',
        'Europe loved Prolog. America loved Lisp. War was declared.',
        'Japan spent billions on Prolog-based AI in the 1980s. It did not end well.',
        'Prolog is Turing complete. This is both a feature and a warning.',
        'The cut operator (!) can ruin your day if used incorrectly.',
        'Datalog is Prolog without the existential dread.',
        'ISO Prolog standard exists. Most people ignore it.'
    ]),
    write(Fact), nl.

number_game :-
    write('Think of a number (1-100). I will guess it.'), nl,
    random(1, 101, Guess),
    write('Is your number '), write(Guess), write('?'), nl,
    write('(reply: higher. / lower. / correct.) '),
    read(Response),
    play_game(Response, Guess, 1, 1, 100).

play_game(correct, Guess, Attempts, _, _) :-
    write('Guessed '), write(Guess), write(' in '), write(Attempts), write(' attempts!'), nl.
play_game(higher, Guess, Attempts, Low, High) :-
    NewLow is Guess + 1,
    random(NewLow, High, NewGuess),
    write('Is it '), write(NewGuess), write('? '),
    read(NewResponse),
    play_game(NewResponse, NewGuess, Attempts + 1, NewLow, High).
play_game(lower, Guess, Attempts, Low, High) :-
    NewHigh is Guess - 1,
    random(Low, NewHigh, NewGuess),
    write('Is it '), write(NewGuess), write('? '),
    read(NewResponse),
    play_game(NewResponse, NewGuess, Attempts + 1, Low, NewHigh).

print_list([]).
print_list([H|T]) :- write('  - '), write(H), nl, print_list(T).

:- initialization(main).
