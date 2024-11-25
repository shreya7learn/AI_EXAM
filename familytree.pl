Corrected Code
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if Ajay is Bobby's father
    (father(ajay, bobby) -> write('Ajay is Bobby\'s father.'), nl;
                            write('Ajay is not Bobby\'s father.'), nl),

    % Query 2: Check if Mary is Lisa's mother
    (mother(mary, lisa) -> write('Mary is Lisa\'s mother.'), nl;
                           write('Mary is not Lisa\'s mother.'), nl),

    % Query 3: Find all siblings of Lisa
    findall(Sibling, (brother(Sibling, lisa) ; sister(Sibling, lisa)), Siblings),
    (Siblings \= [] -> write('Siblings of Lisa: '), write(Siblings), nl;
                       write('Lisa has no siblings.'), nl),

    % Query 4: Find all children of Ajay
    findall(Child, parent(ajay, Child), Children),
    (Children \= [] -> write('Children of Ajay: '), write(Children), nl;
                       write('Ajay has no children.'), nl),

    % Query 5: Check if Ajay is Lisa's grandfather
    (grandfather(ajay, lisa) -> write('Ajay is Lisa\'s grandfather.'), nl;
                                write('Ajay is not Lisa\'s grandfather.'), nl),

    halt.

% Facts
male(ajay).
male(bobby).
male(chatur).
male(david).
male(akash).
female(emma).
female(lisa).
female(mary).
female(jerry).
female(miya).

parent(ajay, bobby).
parent(bobby, lisa).
parent(mary, jerry).
parent(jerry, lisa).
parent(akash, miya).
parent(ajay, david).

% Rules
father(X, Y) :-
    parent(X, Y),
    male(X).

mother(X, Y) :-
    parent(X, Y),
    female(X).

brother(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    male(X),
    X \= Y.

sister(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    female(X),
    X \= Y.

grandfather(X, Y) :-
    father(X, Z),
    parent(Z, Y).
Key Changes and Additions
Improved Queries in main:

Added meaningful checks for relationships like siblings and children.
Used findall/3 to collect lists of relationships such as siblings and children.
Included appropriate conditional checks to avoid empty list outputs.
Corrected Formatting:

Fixed the use of write/1 for better clarity in outputs.
Ensured line breaks after each query for cleaner formatting using nl/0.
Additional Queries:

Added queries to list siblings of Lisa and children of Ajay.
Included a check for Ajay being Lisa's grandfather.
