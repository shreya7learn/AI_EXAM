#include <stdio.h>
#define max_v 100

struct Stack {
    int data[max_v];
    int top;
};
/*struct Stack: Defines a stack with:
data[max_v]: An array to hold the elements (in this case, the vertices).
top: Tracks the index of the top element in the stack. Initially, the stack is empty, so top is set to -1.*/

void ini_stack(struct Stack *stack) {
    stack->top = -1;
}
/*ini_stack: Initializes the stack by setting the top to -1, indicating that the stack is empty.*/

int isEmpty(struct Stack *stack) {
    return (stack->top == -1);
}
/*isEmpty: Returns 1 if the stack is empty (top == -1), otherwise returns 0*/
void push(struct Stack *stack, int vertex) {
    if (stack->top >= max_v - 1) {
        printf("Stack overflow\n");
        return;
    }
    stack->data[++stack->top] = vertex;
}
/*push: Adds a vertex to the stack:
First, it checks if the stack is full (top >= max_v - 1). If the stack is full, it prints an error message.
If not, it increments the top and adds the vertex at the top position of the data array.*/
int pop(struct Stack *stack) {
    if (isEmpty(stack)) {
        printf("Stack underflow\n");
        return -1; // Error value
    }
    return stack->data[stack->top--];
}
/*pop: Removes a vertex from the stack:
First, it checks if the stack is empty using the isEmpty function. If the stack is empty, it prints an error message and returns -1.
If the stack is not empty, it retrieves the top element (stack->data[stack->top]) and decrements top to point to the next element below.*/
void dfs(int start, int matrix[max_v][max_v], int visited[], int n) {
    struct Stack stack;
    ini_stack(&stack);
    push(&stack, start);
    visited[start] = 1;

    while (!isEmpty(&stack)) {
        int vertex = pop(&stack);
        printf("-> %d ", vertex);

        for (int i = 0; i < n; i++) {
            if (matrix[vertex][i] && !visited[i]) {
                push(&stack, i);
                visited[i] = 1;
            }
        }
    }
}
/*DFS Logic:
The function takes the starting vertex (start), an adjacency matrix (matrix), a visited array (visited[]), and the number of vertices (n) as parameters.
A stack is used to hold the vertices during traversal.
The starting vertex is pushed onto the stack, and it is marked as visited.
The algorithm enters a loop where it repeatedly pops vertices from the stack:
For each popped vertex, it explores all of its unvisited neighbors (based on the adjacency matrix). If an unvisited neighbor is found, it is pushed onto the stack and marked as visited.
This continues until the stack is empty, indicating that all reachable vertices have been visited.*/
int main() {
    int n = 6;

    int matrix[max_v][max_v] = {
        {0, 1, 1, 0, 0, 0},
        {1, 0, 1, 1, 0, 0},
        {1, 1, 0, 1, 1, 0},
        {0, 1, 1, 0, 1, 1},
        {0, 0, 1, 1, 0, 1},
        {0, 0, 0, 1, 1, 0}
    };

    int visited[max_v];
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    int start = 0;

    printf("DFS for the given matrix:\n");
    dfs(start, matrix, visited, n);

    return 0;
}
/*Graph Representation:

The graph is represented as an adjacency matrix (matrix[max_v][max_v]), where matrix[i][j] = 1 indicates an edge between vertex i and vertex j.
For this example, n = 6, meaning the graph has 6 vertices.
Visited Array:

The visited array keeps track of which vertices have been visited during the DFS traversal.
DFS Call:

The DFS algorithm starts from vertex 0 (start = 0), and the dfs function is called to explore the graph.
Concepts Used
Stack: The DFS algorithm uses a stack to remember which vertex to visit next. It pushes neighbors of the current vertex onto the stack and pops the next vertex to explore.
Adjacency Matrix: An adjacency matrix is used to represent the graph. This matrix stores information about which vertices are connected to each other.
Visited Array: This array ensures that each vertex is visited only once, preventing infinite loops in cyclic graphs.
DFS Algorithm
Initialize:

Create a stack.
Mark the start vertex as visited and push it onto the stack.
While Stack is Not Empty:

Pop a vertex from the stack.
For each unvisited neighbor of the vertex, push it onto the stack and mark it as visited.
Print the current vertex.
Repeat until the stack is empty.

Pseudocode
vbnet
Copy code
DFS(start, matrix, visited, n):
    Initialize stack
    Push start vertex onto stack
    Mark start vertex as visited

    while stack is not empty:
        vertex = Pop from stack
        Print vertex

        for each i from 0 to n-1:
            if matrix[vertex][i] is 1 and visited[i] is 0:
                Push i onto stack
                Mark i as visited
This pseudocode follows the steps described in the algorithm and is a high-level representation of the DFS traversal logic.*/