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
These examples cover a variety of scenarios, such as relationships, classifications, systems, and interactions. Each one introduces unique facts and rules that can be queried, making them excellent examples for an AI lab exam.







You said:
explain these code format to me
ChatGPT said:
ChatGPT
The format of these Prolog programs is consistent with a typical declarative programming paradigm, where we define facts, rules, and queries. Here's a breakdown of the code structure and how it works in general:

1. Initialization (:- initialization(main).)
This line ensures that when the program is executed, it starts by calling the main/0 predicate.
Without this, Prolog would simply load the facts and rules but not execute any queries automatically.
2. The main/0 Predicate
This is the main entry point of the program. It contains:
Queries to test relationships or retrieve data.
Conditional checks using -> (if-then-else) for verifying specific facts or rules.
Calls to findall/3 to collect results into lists.
Output using write/1 or nl/0 for formatting the results.
3. Facts
Facts define static knowledge or relationships about the world.
Syntax: <predicate>(<entity1>, <entity2>).
Example: manager(alice, bob). means Alice is a manager of Bob.
Facts have no conditions; they are always true when queried.
4. Rules
Rules define relationships or logic based on conditions. They are like "if-then" statements.
Syntax: <predicate>(<args>) :- <condition1>, <condition2>, ... .
Example:
prolog
Copy code
under_supervision(X, Y) :- manager(X, Y).
under_supervision(X, Y) :- manager(X, Z), under_supervision(Z, Y).
This rule states:
Y is under the supervision of X directly if X is Y's manager.
Y is under the supervision of X indirectly if X manages someone who supervises Y.
5. Queries
Queries test relationships or extract data based on facts and rules.
In main/0, we use:
Direct Queries: Check a relationship.

prolog
Copy code
father(ajay, bobby) -> write('Ajay is Bobby\'s father.'), nl;
                       write('Ajay is not Bobby\'s father.'), nl.
This checks if ajay is the father of bobby and outputs accordingly.

Data Retrieval: Use findall/3 to collect multiple results into a list.

prolog
Copy code
findall(Employee, under_supervision(alice, Employee), Employees).
This collects all employees under Alice's supervision into the list Employees.

Conditions: The -> ; syntax implements if-then-else logic.

prolog
Copy code
(condition -> true_action; false_action).
6. Input and Output
Input: Not present in the current examples but can be added using predicates like read/1.
Output:
write/1: Writes output to the console.
prolog
Copy code
write('Hello, world!').
nl/0: Inserts a new line for formatting.
prolog
Copy code
write('Hello'), nl, write('World').
Output:
Copy code
Hello
World
7. Prolog Control Flow
Execution Order:
When the program starts, Prolog executes main/0.
Inside main/0, each query runs sequentially.
Queries with findall/3 gather data, while conditions with -> ; evaluate to execute one of the branches.
Logical Inference:
Prolog evaluates queries by matching them to facts or rules.
For rules, it recursively applies conditions to find matches.
Specific Features in the Examples
Family Tree Example
Demonstrates relationships like parenthood (father/2, mother/2) and hierarchy (grandfather/2).
Uses facts (parent/2) and gender-specific rules (male/1, female/1).
Employee-Manager Example
Focuses on hierarchical relationships, showing both direct and indirect supervision (under_supervision/2).
University Courses Example
Combines relationships (teaches/2, enrolled/2) to link professors and students with courses.
Uses findall/3 to list all students in a course or all courses taught by a professor.
Traffic Light System Example
Simple mapping of traffic light states to actions (action/2).
Uses direct facts to represent static knowledge.
Library System Example
Models library operations like checking availability of books and listing borrowed books.
Combines facts (book/1, borrowed/2) with a rule (available/1) to derive knowledge dynamically.
Geographical Relationships Example
Demonstrates city-country relationships (city_in/2) and queries related to locations (located_in/2).
Animal Classification Example
Explores basic taxonomy relationships like bird or mammal classification (is_bird/1, mammal/1).
Why This Format Is Useful
Modularity: Facts, rules, and queries are clearly separated.
Dynamic Queries: Flexible querying of relationships using rules.
Real-World Applications: Demonstrates hierarchical relationships, classification, and data retrieval.
Readable Output: The use of write/1 and findall/3 ensures user-friendly outputs.
This format is versatile and well-suited for AI lab exams to test Prolog fundamentals in various contexts.






1. Social Network Connections
Code Example:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if Alice and Bob are direct friends
    (friend(alice, bob) -> write('Alice and Bob are friends.'), nl;
                           write('Alice and Bob are not friends.'), nl),

    % Query 2: Find all friends of Alice
    findall(Friend, friend(alice, Friend), Friends),
    write('Friends of Alice: '), write(Friends), nl,

    % Query 3: Check if Alice and Carol are indirectly connected (friends of friends)
    (indirect_friend(alice, carol) -> write('Alice and Carol are connected.'), nl;
                                      write('Alice and Carol are not connected.'), nl),

    halt.

% Facts
friend(alice, bob).
friend(bob, carol).
friend(carol, diana).

% Rule for indirect friendship (friend of a friend is a friend)
indirect_friend(X, Y) :- friend(X, Z), friend(Z, Y).
Explanation:
Facts define direct friendships between people.
Rule: indirect_friend(X, Y) checks if X and Y are friends indirectly by having a mutual friend.
Queries are used to check if two people are friends or connected through mutual friends.
2. Voting System
Code Example:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if John is eligible to vote
    (eligible_to_vote(john) -> write('John is eligible to vote.'), nl;
                               write('John is not eligible to vote.'), nl),

    % Query 2: List all eligible voters
    findall(Voter, eligible_to_vote(Voter), Voters),
    write('Eligible voters: '), write(Voters), nl,

    halt.

% Facts
citizen(john).
citizen(mary).
citizen(anna).
age(john, 30).
age(mary, 25).
age(anna, 17).

% Rule to determine voting eligibility (must be citizen and 18 or older)
eligible_to_vote(X) :-
    citizen(X),
    age(X, Age),
    Age >= 18.
Explanation:
Facts define individuals and their characteristics (citizenship and age).
Rule: eligible_to_vote(X) checks if a person is a citizen and over 18 years old.
Queries can determine the eligibility of individuals and list all eligible voters.
3. Course Prerequisite System
Code Example:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if student can take "Advanced AI"
    (can_take(john, 'Advanced AI') -> write('John can take Advanced AI.'), nl;
                                      write('John cannot take Advanced AI.'), nl),

    % Query 2: List all courses John can take
    findall(Course, can_take(john, Course), Courses),
    write('Courses John can take: '), write(Courses), nl,

    halt.

% Facts
course('AI').
course('Machine Learning').
course('Advanced AI').

prerequisite('Machine Learning', 'AI').
prerequisite('Advanced AI', 'Machine Learning').

% Rule to check if a student can take a course (based on prerequisites)
can_take(Student, Course) :-
    not(prerequisite(Course, _)).
can_take(Student, Course) :-
    prerequisite(Course, Prerequisite),
    can_take(Student, Prerequisite).
Explanation:
Facts define courses and their prerequisites.
Rule: can_take(Student, Course) checks if a student can take a course based on the prerequisites.
Queries can determine if a student is eligible for a course and list courses they can take.
4. Bank Account System
Code Example:
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if Bob's account is overdrawn
    (overdrawn(bob) -> write('Bob\'s account is overdrawn.'), nl;
                       write('Bob\'s account is not overdrawn.'), nl),

    % Query 2: List all accounts with overdrawn balances
    findall(Account, overdrawn(Account), OverdrawnAccounts),
    write('Overdrawn accounts: '), write(OverdrawnAccounts), nl,

    halt.

% Facts
account(bob, 100).
account(alice, -50).
account(charlie, 200).

% Rule to check if an account is overdrawn (balance < 0)
overdrawn(Account) :-
    account(Account, Balance),
    Balance < 0.
Explanation:
Facts define account holders and their balances.
Rule: overdrawn(Account) checks if an account balance is less than 0.
Queries can determine if an account is overdrawn and list all such accounts.
5. Expert System for Medical Diagnosis
Code Example (Expert System for Diagnosing Cold or Flu):
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Diagnose if the patient has a cold or flu
    (diagnose_cold_or_flu(Patient) -> write('Diagnosed with cold or flu.'), nl;
                                      write('Unable to diagnose.'), nl),

    halt.

% Facts about symptoms
symptom(john, fever).
symptom(john, cough).
symptom(mary, sore_throat).
symptom(mary, headache).
symptom(susan, fever).
symptom(susan, body_aches).
symptom(susan, cough).

% Rules for diagnosis
diagnose_cold_or_flu(Patient) :-
    symptom(Patient, fever),
    symptom(Patient, cough),
    not(symptom(Patient, sore_throat)).

diagnose_cold_or_flu(Patient) :-
    symptom(Patient, sore_throat),
    symptom(Patient, headache),
    not(symptom(Patient, body_aches)).
Explanation:
Facts define symptoms associated with different patients.
Rules: diagnose_cold_or_flu(Patient) applies different conditions to diagnose cold or flu:
If a patient has both fever and cough but not sore throat, they have the flu.
If a patient has sore throat and headache, they have a cold.
Query: The diagnosis is made based on the symptoms provided.
6. Expert System for Loan Eligibility
Code Example (Loan Eligibility Expert System):
prolog
Copy code
:- initialization(main).

main :-
    % Query 1: Check if Alice is eligible for a loan
    (eligible_for_loan(alice) -> write('Alice is eligible for the loan.'), nl;
                                write('Alice is not eligible for the loan.'), nl),

    halt.

% Facts about individuals
income(alice, 6000).
credit_score(alice, 750).
age(alice, 30).

income(bob, 3000).
credit_score(bob, 600).
age(bob, 45).

% Rules for loan eligibility
eligible_for_loan(Person) :-
    income(Person, Income),
    credit_score(Person, CreditScore),
    age(Person, Age),
    Income >= 5000,
    CreditScore >= 700,
    Age >= 21,
    Age =< 65.
Explanation:
Facts: Income, credit score, and age of potential borrowers.
Rules: eligible_for_loan(Person) checks if an individual meets the conditions for a loan:
Income must be at least 5000.
Credit score must be 700 or higher.
Age must be between 21 and 65.
Query: Determines if Alice (or any other person) is eligible for a loan.
Expert System Example Breakdown
Medical Diagnosis Expert System:

Uses symptoms to infer potential diagnoses (cold vs. flu).
Relies on facts (observed symptoms) and rules (if-then logic for diagnosis).
Loan Eligibility Expert System:

Evaluates eligibility based on financial and personal criteria.
Rules are used to check if a person qualifies for a loan based on income, credit score, and age.
Summary of Concepts
Facts represent the knowledge base (e.g., symptoms, financial details, relationships).
Rules allow for inference from facts (e.g., determining if someone is eligible for a loan, diagnosing a disease).
Queries are used to test relationships or retrieve information from the knowledge base.
Expert Systems use rules to provide automated decision-making for specific tasks or diagnoses.
These examples illustrate how Prolog can be used for various AI-related tasks, from social networks to expert systems for decision-making and diagnosis.






