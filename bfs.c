#include <stdio.h>
#define max_v 100

struct Queue {
    int data[max_v];
    int front;
    int rear;
};
/*struct Queue: Defines a queue with:
data[max_v]: An array to hold the elements (in this case, the vertices).
front: Points to the front of the queue.
rear: Points to the rear of the queue.*/
void ini_queue(struct Queue *queue) {
    queue->front = 0;
    queue->rear = -1;
}
/*ini_queue: Initializes the queue by setting the front to 0 and rear to -1, indicating that the queue is empty.*/
int isEmpty(struct Queue *queue) {
    return queue->front > queue->rear;
}
/*isEmpty: Returns 1 if the queue is empty (front > rear), otherwise returns 0.*/
void enqueue(struct Queue *queue, int vertex) {
    if (queue->rear >= max_v - 1) {
        printf("Queue overflow\n");
        return;
    }
    queue->data[++queue->rear] = vertex;
}
/*enqueue: Adds a vertex to the queue:
First, it checks if the queue is full (rear >= max_v - 1). If the queue is full, it prints an overflow error.
If not, it increments rear and inserts the vertex at the rear position in the data array.*/
int dequeue(struct Queue *queue) {
    if (isEmpty(queue)) {
        printf("Queue underflow\n");
        return -1; // Error value
    }
    return queue->data[queue->front++];
}
/*dequeue: Removes and returns a vertex from the front of the queue:
First, it checks if the queue is empty using isEmpty. If the queue is empty, it prints an underflow error and returns -1.
If the queue is not empty, it retrieves the vertex at the front and increments the front index.*/
void bfs(int start, int matrix[max_v][max_v], int visited[], int n) {
    struct Queue queue;
    ini_queue(&queue);
    enqueue(&queue, start);
    visited[start] = 1;

    printf("BFS Traversal: ");
    while (!isEmpty(&queue)) {
        int vertex = dequeue(&queue);
        printf("%d ", vertex);

        for (int i = 0; i < n; i++) {
            if (matrix[vertex][i] && !visited[i]) {
                enqueue(&queue, i);
                visited[i] = 1;
            }
        }
    }
    printf("\n");
}
/*BFS Logic:
The function takes the starting vertex (start), an adjacency matrix (matrix), a visited array (visited[]), and the number of vertices (n) as parameters.
The queue is initialized and the starting vertex is enqueued and marked as visited.
The algorithm enters a loop where it repeatedly dequeues vertices from the queue:
For each dequeued vertex, it explores all its unvisited neighbors (based on the adjacency matrix). If an unvisited neighbor is found, it is enqueued and marked as visited.
This continues until the queue is empty, indicating that all reachable vertices have been visited.*/
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

    printf("BFS for the given matrix:\n");
    bfs(start, matrix, visited, n);

    return 0;
}
/*Graph Representation:

The graph is represented as an adjacency matrix (matrix[max_v][max_v]), where matrix[i][j] = 1 indicates an edge between vertex i and vertex j.
For this example, n = 6, meaning the graph has 6 vertices.
Visited Array:

The visited array keeps track of which vertices have been visited during the BFS traversal.
BFS Call:

The BFS algorithm starts from vertex 0 (start = 0), and the bfs function is called to explore the graph.
Concepts Used
Queue: The BFS algorithm uses a queue to hold the vertices that need to be explored. It follows a FIFO (First In, First Out) principle, where the first vertex added to the queue is the first one to be dequeued and explored.
Adjacency Matrix: An adjacency matrix is used to represent the graph. This matrix stores information about which vertices are connected to each other.
Visited Array: This array ensures that each vertex is visited only once, preventing infinite loops in cyclic graphs.
BFS Algorithm
Initialize:

Create a queue.
Mark the start vertex as visited and enqueue it.
While Queue is Not Empty:

Dequeue a vertex from the queue.
For each unvisited neighbor of the vertex, enqueue it and mark it as visited.
Print the current vertex.
Repeat until the queue is empty.

Pseudocode
vbnet
Copy code
BFS(start, matrix, visited, n):
    Initialize queue
    Enqueue start vertex
    Mark start vertex as visited

    while queue is not empty:
        vertex = Dequeue from queue
        Print vertex

        for each i from 0 to n-1:
            if matrix[vertex][i] is 1 and visited[i] is 0:
                Enqueue i into queue
                Mark i as visited
This pseudocode provides a high-level overview of the BFS traversal logic. It shows how BFS explores the graph level by level, visiting neighbors of each vertex before moving deeper into the graph.*/