Here are more diverse Prolog examples that can be asked in an AI lab exam, covering different domains and scenarios. Additionally, I'll provide an example of an expert system for diagnosis, which is a common application in AI labs.

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