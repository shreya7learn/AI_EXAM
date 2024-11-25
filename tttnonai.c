#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define size 3
/*#include <stdio.h>: Includes the standard input-output library, allowing us to use functions like printf and scanf.
#include <stdlib.h>: Includes the standard library to use functions like rand and srand, which are used for random number generation.
#include <time.h>: This library is used to seed the random number generator, so the computer's moves are unpredictable.
#define size 3: Defines a constant size with the value 3, representing the size of the Tic-Tac-Toe board (3x3 grid).
*/
void printboard(char board[size][size]){
    for (int i = 0; i < size; i++){
        for (int j = 0; j < size; j++){
            printf(" %c ",board[i][j]);
            if (j<size-1){
                printf("|");
            }
        }
        printf("\n");
        if (i<size-1){
                printf("---+---+---\n");
            }     
    }
    
}
/*
Purpose: This function prints the current state of the Tic-Tac-Toe board.
Implementation:
A nested loop iterates over each row and column of the board.
It prints each character ('X', 'O', or a space ' ') in a grid format.
It prints a | symbol between columns, but not after the last column.
After each row, it prints ---+---+--- to separate the rows, except for the last row.*/

int checkwin(char board[size][size]){
    int row , col;
    for (int i = 0; i < size; i++)
    {
        if(board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != ' ')
        return 1;
        if(board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != ' ' )
        return 1;
    }

    if(board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != ' ')
        return 1;
    if(board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != ' ' )
        return 1;
    
    return 0;
}
/*Purpose: This function checks if either player (User or Computer) has won the game.
Implementation:
The function checks all possible winning conditions:
Rows: It checks if all three cells in any row contain the same symbol ('X' or 'O').
Columns: It checks if all three cells in any column contain the same symbol.
Diagonals: It checks the two diagonals to see if all three cells contain the same symbol.
If any of these conditions are met (and the cells are not empty), the function returns 1, indicating a win. Otherwise, it returns 0.*/
int boardfull(char board[size][size]){
    for (int i = 0; i < size; i++){
        for (int j = 0; j < size; j++){
            if(board[i][j] == ' ' ) return 0;
        }
    }
    return 1;
}
/*Purpose: This function checks if the board is completely filled with 'X' and 'O' (i.e., no empty spaces ' ').
Implementation:
It iterates through each cell in the board. If it finds an empty space (' '), it returns 0 (indicating the board is not full).
If it doesn't find any empty spaces, it returns 1 (indicating the board is full, potentially a draw).
*/

void usermove(char board[size][size]){
    int row,col;
    do{
    printf("enter row and col between 1-3: ");
    scanf("%d %d",&row ,&col );
    if(row < 1 || col < 1 || row > size || col > size || board[row-1][col-1] != ' '){
        printf("invalid input ");
    }
    }while(row < 1 || col < 1 || row > size || col > size || board[row-1][col-1] != ' ');
    board[row-1][col-1]='X';

}
/*
Purpose: This function allows the user to input their move (row and column) to place an 'X' on the board.
Implementation:
A do-while loop ensures the user enters a valid move. The conditions checked are:
The row and column are within the valid range (1 to 3).
The selected cell is empty (' ').
If the move is valid, the user’s symbol ('X') is placed on the board.
If the move is invalid, the user is prompted to re-enter their move.*/

void compmove(char board[size][size]){
    int row,col;
    do{
     row = rand() % size;
     col = rand() % size;
    }while(board[row][col] != ' ');
    board[row][col] = 'O';

}
/*
Purpose: This function generates a random move for the computer (placing an 'O' on the board).
Implementation:
The rand() function generates random row and column indices (between 0 and 2 for a 3x3 board).
It checks if the selected cell is empty. If not, it generates a new random position.
Once an empty cell is found, the computer's symbol ('O') is placed on the board.*/
int main(){
    char board[size][size]={
        {' ',' ',' '},
        {' ',' ',' '},
        {' ',' ',' '}
    };
    srand(time(0));

    printf("welcome to tic tac toe game!! \n");

    while(1){
        printboard(board);
        usermove(board);
        if(checkwin(board)){
            printboard(board);
            printf("you won\n");
            break;
        }
        if (boardfull(board))
        {
            printboard(board);
            printf("draw\n");
            break;
        }
        
        compmove(board);
        if(checkwin(board)){
            printboard(board);
            printf("computer won\n");
            break;
        }
        if (boardfull(board))
        {
            printboard(board);
            printf("draw\n");
            break;
        }
        
    }
    printf("thank you for playing");
    return 0;
}
/*
Purpose: This is the main control flow of the game.
Implementation:
Initial Setup: The board is initialized as a 3x3 grid filled with spaces ' '. The srand(time(0)) call seeds the random number generator based on the current time, making the computer's moves random each time the game is played.
Game Loop:
The game runs inside a while(1) loop until a win or draw occurs.
The board is printed, the user is prompted to make a move, and then the computer makes its move.
After each move, it checks if there is a winner using checkwin. If a player wins, it prints the result and exits the loop.
If the board is full without a winner, it declares a draw.
After the game ends, a message is printed thanking the player.*/

/*
Here's an algorithm for the Tic-Tac-Toe game (User vs. Computer) based on the C code provided:

Algorithm for Tic-Tac-Toe (User vs. Computer)
Initialize the Game Board:

Create a 3x3 matrix (board) initialized with empty spaces (' ').
Display the welcome message and explain the game rules.
Main Game Loop:

Repeat the following steps until there is a winner or the board is full (resulting in a draw):
a. Print the Current Board:

Print the game board after each move using the printboard function.
b. User's Turn (Player Input):

Prompt the user to enter their move (row and column between 1 and 3).
Ensure that the input is valid:
The row and column are within the range of 1 to 3.
The selected cell is not already occupied.
If the input is invalid, prompt the user to enter again.
Place the user's symbol ('X') at the specified position on the board.
c. Check for a Winner (User):

After the user’s move, check if the user has won the game using the checkwin function.
If the user wins, print the board and display "You won!" and exit the loop.
d. Check if the Board is Full (Draw Check):

If the board is full, declare the game a draw and exit the loop.
e. Computer's Turn (Random Move):

The computer generates a random move (row and column between 0 and 2) using the rand() function.
Ensure that the selected cell is empty.
Place the computer's symbol ('O') at the selected position on the board.
f. Check for a Winner (Computer):

After the computer’s move, check if the computer has won the game using the checkwin function.
If the computer wins, print the board and display "Computer won!" and exit the loop.
g. Check if the Board is Full (Draw Check Again):

If the board is full, declare the game a draw and exit the loop.
End the Game:

After the loop ends (either user wins, computer wins, or draw), print "Thank you for playing!" and end the program.*/