#include<stdio.h>
#include<limits.h>

#define AI 'O'
#define Player 'X'

void printboard(char board[3][3]){
    for (int i = 0; i < 3; i++){
        for (int j =0; j < 3; j++){
            printf(" %c ",board[i][j]);
            if(j<2)printf("|");
            
        }printf("\n");
        if(i<2)printf("---+---+---+\n");
    }
}

int boardfull(char board[3][3]){
    for (int i = 0; i < 3; i++){
        for (int j =0; j < 3; j++){
            if(board[i][j]== ' ')return 0;
        }
}
return 1;
}

int checkwin(char board[3][3], char player){
    for (int i = 0; i < 3; i++)
    {
        if((board[i][0] == player && board[i][1] == player && board[i][2] == player) ||
          (board[0][i] == player && board[1][i] == player && board[2][i] == player)){
            return 1;
        }
    }
    if ((board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
    ( board[0][2] == player && board[1][1] == player && board[2][0] == player))
    {
        return 1;
    }

    return 0;
}

int minimax(char board[3][3],int ismaximizing){
    if (checkwin(board,Player))
    {return -1;
    }
    if (checkwin(board,AI))
    {return 1;
    }
    if (boardfull(board))
    {
        return 0;
    }
    
    if (ismaximizing)
    {
        int bestscore = INT_MIN;
        for (int i = 0; i < 3; i++){
            for (int j = 0; j < 3; j++){
                if(board[i][j]==' '){
                board[i][j]=AI;

                int score = minimax(board,0);
                board[i][j]=' ';
                if(score > bestscore){
                    bestscore=score;
                }
                }
            }
            
        }
        return bestscore;
        
    }
    else{
        int bestscore = INT_MAX;
        for (int i = 0; i < 3; i++){
            for (int j = 0; j < 3; j++){
                if(board[i][j]==' '){
                board[i][j]=Player;

                int score = minimax(board,1);
                board[i][j]=' ';
                if(score < bestscore){
                    bestscore=score;
                }
                }
            }
            
        }
        return bestscore;
    }
}

void bestmove(char board[3][3],int *bestrow,int *bestcol){
    int bestscore = INT_MIN;
        for (int i = 0; i < 3; i++){
            for (int j = 0; j < 3; j++){
                if(board[i][j]==' '){
                board[i][j]=AI;
                int score = minimax(board,0);
                board[i][j]=' ';
                if(score > bestscore){
                    bestscore=score;
                    *bestrow= i;
                    *bestcol= j;
                }
                }
            }
            
        }
}

int main(){
    char board[3][3]={
        {' ',' ',' '},
        {' ',' ',' '},
        {' ',' ',' '}
    };
    int currentplayer = 1;

    while (1)
    {
        printboard(board);
        if (currentplayer)
        {
            int row,col;
            printf("enter row and col between 1-3: " );
            scanf("%d %d", &row,&col);
            row--;
            col--;
            if ((board[row][col]!=' ') || (row < 0 || row >= 3 || col < 0 || col >= 3))
            {
                printf("invalid input\n");
                continue;
            }
            board[row][col]= Player;
        }
        else
        {
            int bestrow,bestcol;
            bestmove(board,&bestrow,&bestcol);
            board[bestrow][bestcol]= AI;
            printf("Ai chose postion: (%d,%d)\n",bestrow+1,bestcol+1);
        }

        if (checkwin(board,Player))
        {
            printboard(board);
            printf("you win\n");
            break;
        }
        if (checkwin(board,AI))
        {
            printboard(board);
            printf("Ai won\n");
            break;
        }
        if (boardfull(board))
        {
            printboard(board);
            printf("draw\n");
            break;
        }
        
        
        currentplayer = !currentplayer;
        
    }
    return 0;
    
}
/*
Explanation of the Code in Detail
This C program is a Tic-Tac-Toe game between a human player (X) and a computer (O). The game uses the Minimax algorithm to allow the computer to make intelligent moves by evaluating possible board states.

Concepts and Functions Used in the Code
Constants:

#define AI 'O': Represents the computer's move.
#define Player 'X': Represents the player's move.
printboard function:

Purpose: Prints the current state of the Tic-Tac-Toe board.
It prints the 3x3 grid with rows and columns. It also prints | between columns and ---+---+--- between rows to make the board visually structured.
boardfull function:

Purpose: Checks if the board is completely filled (i.e., no empty spaces left).
How it works: It iterates over each cell in the board, and if any cell contains a space (' '), it returns 0 (board not full). If all cells are filled, it returns 1.
checkwin function:

Purpose: Checks if the given player has won the game.
It checks for a win in:
Rows: Three consecutive symbols of the same player.
Columns: Three consecutive symbols of the same player.
Diagonals: Top-left to bottom-right and top-right to bottom-left.
Return: 1 if the player has won, 0 if not.
minimax function:

Purpose: Implements the Minimax algorithm to simulate the optimal moves for the computer.
How it works:
Base Case:
If the player (X) has won, the score is -1 (bad for the computer).
If the AI (O) has won, the score is 1 (good for the computer).
If the board is full (draw), the score is 0.
Recursive Case:
If it's the maximizing player's turn (AI), the algorithm tries all possible moves and selects the one with the highest score.
If it's the minimizing player's turn (Player), the algorithm tries all possible moves and selects the one with the lowest score.
Return: The best score for the current player (maximizing or minimizing).
bestmove function:

Purpose: Finds the best move for the AI by evaluating each possible move using the Minimax algorithm.
It iterates over all empty cells on the board, simulates the AI's move, and calls the minimax function to get the score for each move.
The best move is the one with the highest score.
Return: The row and column of the best move for the AI.
main function:

Purpose: The main driver of the game, alternating between the human player's turn and the computer's turn.
How it works:
The board is initialized as a 3x3 grid of empty spaces.
The currentplayer variable keeps track of whose turn it is. 1 for the player (X) and 0 for the AI (O).
Player's Turn: The player inputs the row and column where they want to place their X. The program ensures that the input is valid (within bounds and the cell is empty).
AI's Turn: The AI calculates the best move using the bestmove function and places its O.
After each move, the program checks if there is a winner or if the board is full (draw).
The game ends when either the player wins, the AI wins, or the board is full.
Key Concepts and Techniques Used
Minimax Algorithm:

The Minimax algorithm is a decision-making algorithm used in two-player games (like Tic-Tac-Toe) to minimize the possible loss for the worst-case scenario.
The algorithm simulates all possible moves of both players, evaluating the board state after each move recursively, and assigns scores to those moves. It chooses the move with the best possible outcome based on the player's strategy (either maximizing or minimizing the score).
Recursion:

The minimax function uses recursion to simulate the game. It calls itself to simulate deeper levels of possible moves and outcomes, making it a powerful method to calculate the optimal move in a game with a small search space (like Tic-Tac-Toe).
Game Loop:

The game runs in a loop where the player and AI alternate turns until there is a winner or the board is full.
The board is printed after each move, and the program checks for a win or a draw after every move.
Input Validation:

The program ensures that the player’s move is valid (within bounds and on an empty cell).
Artificial Intelligence:

The AI uses the Minimax algorithm to choose the best possible move. This makes it capable of playing optimally, where the AI will never lose if it plays correctly.
Algorithm for the Code
Here is a high-level algorithm for the program:

Algorithm
Initialize Game Board:

Create a 3x3 board initialized with empty spaces ' '.
Define the constants AI = 'O' and Player = 'X'.
Main Game Loop:

While the game is ongoing:
Print the Board: Display the current state of the game board.

Player's Turn:

Prompt the player to input row and column (between 1-3).
Validate the input:
Check if the input is within bounds.
Check if the selected cell is empty.
Place the player's symbol ('X') on the board.
Check for Winner:

If the player wins, print the board and announce "You win", then break the loop.
If the AI wins, print the board and announce "AI won", then break the loop.
If the board is full and there is no winner, announce "Draw" and break the loop.
AI's Turn:

Use the bestmove function to calculate the best move for the AI.
Place the AI's symbol ('O') on the board at the best position.
Check for Winner:

Check again if the player or AI has won after the AI's move.
Check for Draw:

Check if the board is full without a winner. If so, it's a draw.
End the Game:

Print the final message: "Thank you for playing".
*/