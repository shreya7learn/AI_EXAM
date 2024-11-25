1. Employee-Manager Relationship
Code:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if Alice is Bob's manager
    (manager(alice, bob) -> write('Alice is Bob\'s manager.'), nl;
                            write('Alice is not Bob\'s manager.'), nl),

    % Query 2: Find all employees under Alice's supervision
    findall(Employee, under_supervision(alice, Employee), Employees),
    (Employees \= [] -> write('Employees under Alice\'s supervision: '), write(Employees), nl;
                        write('Alice has no employees under supervision.'), nl),

    % Query 3: Check if Alice is a senior manager of Frank
    (senior_manager(alice, frank) -> write('Alice is a senior manager of Frank.'), nl;
                                     write('Alice is not a senior manager of Frank.'), nl),
    
    halt.

% Facts
manager(alice, bob).
manager(alice, charlie).
manager(bob, diana).
manager(bob, eric).
manager(charlie, frank).

% Rules
under_supervision(X, Y) :- 
    manager(X, Y).

under_supervision(X, Y) :- 
    manager(X, Z),
    under_supervision(Z, Y).

senior_manager(X, Y) :-
    under_supervision(X, Y).
2. University Courses and Enrollment
Code:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if Alice is enrolled in AI
    (enrolled(alice, ai) -> write('Alice is enrolled in AI.'), nl;
                            write('Alice is not enrolled in AI.'), nl),

    % Query 2: List all students enrolled in AI
    findall(Student, enrolled(Student, ai), Students),
    write('Students enrolled in AI: '), write(Students), nl,

    % Query 3: List all courses taught by Dr. Smith
    findall(Course, teaches(dr_smith, Course), Courses),
    write('Courses taught by Dr. Smith: '), write(Courses), nl,

    halt.

% Facts
teaches(dr_smith, ai).
teaches(dr_smith, ml).
teaches(dr_jones, dbms).

enrolled(alice, ai).
enrolled(bob, ai).
enrolled(charlie, ml).
enrolled(diana, dbms).
3. Traffic Light System
Code:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: What is the action at a red light?
    (action(red, Action), write('At a red light: '), write(Action), nl),

    % Query 2: What is the action at a green light?
    (action(green, Action), write('At a green light: '), write(Action), nl),

    % Query 3: What is the action at a yellow light?
    (action(yellow, Action), write('At a yellow light: '), write(Action), nl),

    halt.

% Facts
action(red, 'Stop').
action(green, 'Go').
action(yellow, 'Prepare to stop').
4. Library System
Code:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if "The Hobbit" is available
    (available('The Hobbit') -> write('The Hobbit is available.'), nl;
                                write('The Hobbit is not available.'), nl),

    % Query 2: List all books borrowed by Alice
    findall(Book, borrowed(alice, Book), Books),
    write('Books borrowed by Alice: '), write(Books), nl,

    % Query 3: Check if "1984" is available
    (available('1984') -> write('1984 is available.'), nl;
                          write('1984 is not available.'), nl),

    halt.

% Facts
book('The Hobbit').
book('1984').
book('Pride and Prejudice').

borrowed(alice, 'Pride and Prejudice').
borrowed(bob, 'The Hobbit').

% Rules
available(Book) :-
    book(Book),
    \+ borrowed(_, Book).
5. Geographical Relationships
Code:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if Paris is in France
    (located_in(paris, france) -> write('Paris is in France.'), nl;
                                  write('Paris is not in France.'), nl),

    % Query 2: List all countries that contain cities
    findall(Country, city_in(_, Country), Countries),
    write('Countries with cities in the database: '), write(Countries), nl,

    % Query 3: List all cities in France
    findall(City, city_in(City, france), Cities),
    write('Cities in France: '), write(Cities), nl,

    halt.

% Facts
city_in(paris, france).
city_in(lyon, france).
city_in(berlin, germany).
city_in(munich, germany).

located_in(City, Country) :-
    city_in(City, Country).
6. Animal Classification
Code:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if a sparrow is a bird
    (is_bird(sparrow) -> write('Sparrow is a bird.'), nl;
                         write('Sparrow is not a bird.'), nl),

    % Query 2: List all animals that are mammals
    findall(Animal, mammal(Animal), Mammals),
    write('Animals that are mammals: '), write(Mammals), nl,

    % Query 3: Check if a dolphin is a mammal
    (mammal(dolphin) -> write('Dolphin is a mammal.'), nl;
                        write('Dolphin is not a mammal.'), nl),

    halt.

% Facts
bird(sparrow).
bird(eagle).
mammal(lion).
mammal(dolphin).

% Rules
is_bird(Animal) :-
    bird(Animal).

is_mammal(Animal) :-
    mammal(Animal).
