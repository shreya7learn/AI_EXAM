import java.util.Scanner;

class IterativeDeepeningDFS {
    private int[][] adjacencyMatrix; 
    private int numberOfVertices;    

    public IterativeDeepeningDFS(int numberOfVertices) {
        this.numberOfVertices = numberOfVertices;
        adjacencyMatrix = new int[numberOfVertices][numberOfVertices];
    }

    public void addEdge(int startVertex, int endVertex) {
        adjacencyMatrix[startVertex][endVertex] = 1;
        adjacencyMatrix[endVertex][startVertex] = 1; 
    }

    // IDDFS Method
    public void performIDDFS(int startVertex, int targetVertex) {
        for (int depth = 0; depth < numberOfVertices; depth++) {
            boolean[] visited = new boolean[numberOfVertices]; 

            boolean found = depthLimitedDFS(startVertex, targetVertex, depth, visited);
            if (found) {
                System.out.println("\nTarget vertex " + (targetVertex + 1) + " found at depth: " + depth);
                return;
            } 
        }

        System.out.println("Target vertex " + (targetVertex + 1) + " not found within the maximum depth of " + numberOfVertices);
    }

    private boolean depthLimitedDFS(int currentVertex, int targetVertex, int depthLimit, boolean[] visited) {

        if (currentVertex == targetVertex) {
            return true;
        }

        if (depthLimit <= 0) {
            return false; 
        }

        visited[currentVertex] = true; 

        for (int i = 0; i < numberOfVertices; i++) {
            if (adjacencyMatrix[currentVertex][i] == 1 && !visited[i]) {

                if (depthLimitedDFS(i, targetVertex, depthLimit - 1, visited)) {
                    return true; 
                }
            }
        }

        return false; 
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter the number of vertices: ");
        int numberOfVertices = sc.nextInt();

        IterativeDeepeningDFS iddfs = new IterativeDeepeningDFS(numberOfVertices);

        System.out.print("Enter the number of edges: ");
        int numberOfEdges = sc.nextInt();

        System.out.println("Enter the edges in the format: startVertex endVertex");
        for (int i = 0; i < numberOfEdges; i++) {
            int startVertex = sc.nextInt() - 1; 
            int endVertex = sc.nextInt() - 1;   
            iddfs.addEdge(startVertex, endVertex);
        }

        System.out.print("Enter the start vertex: ");
        int startVertex = sc.nextInt() - 1; 

        System.out.print("Enter the goal vertex: ");
        int targetVertex = sc.nextInt() - 1; 

        iddfs.performIDDFS(startVertex, targetVertex);

        sc.close();
    }
}
/*
The provided code implements Iterative Deepening Depth-First Search (IDDFS) using an adjacency matrix for a graph. The main objective is to find a target vertex starting from a specified start vertex, and this is done using an iterative deepening strategy to progressively search the graph with increasing depth limits.

Concepts Used:
Graph Representation (Adjacency Matrix):

The graph is represented using an adjacency matrix (a 2D array). Each element adjacencyMatrix[i][j] is 1 if there's an edge between vertices i and j, and 0 otherwise.
This representation allows checking for neighbors in constant time 
𝑂
(
1
)
O(1).
Iterative Deepening Depth-First Search (IDDFS):

Depth-First Search (DFS) is a search algorithm that explores as far as possible along a branch before backtracking.
IDDFS is a combination of DFS and Breadth-First Search (BFS) principles. It performs DFS repeatedly, each time with an increasing depth limit. This allows for an optimal search where we avoid the deep search of DFS while still exploring to all possible depths.
Depth-Limited DFS:

A DFS that restricts its search to a given depth limit. If the limit is reached, the search halts.
How the Code Works:
Graph Representation:
The IterativeDeepeningDFS class has a 2D array adjacencyMatrix to store the graph's structure, where adjacencyMatrix[start][end] = 1 indicates an edge between start and end.
Adding Edges:
The addEdge method adds an edge between two vertices by setting both adjacencyMatrix[startVertex][endVertex] = 1 and adjacencyMatrix[endVertex][startVertex] = 1. This ensures that the graph is undirected.
Performing IDDFS:
The method performIDDFS tries to find the target vertex using IDDFS. It loops over increasing depth limits starting from 0 up to the number of vertices (since in the worst case, the maximum depth of the graph will be the number of vertices). For each depth, it performs a depth-limited DFS.
Depth-Limited DFS:
This is implemented in the depthLimitedDFS method. It:
Starts at currentVertex.
Checks if currentVertex == targetVertex (base case for success).
Recursively explores the neighbors of currentVertex (as long as the depthLimit is greater than 0).
Marks a vertex as visited to avoid revisiting it in the same search.
Main Method:
The main method interacts with the user to get input: the number of vertices, edges, and the vertices of the graph.
After constructing the graph, it calls the performIDDFS method to search for the target vertex.
Algorithm (IDDFS):
Here is the algorithm for the Iterative Deepening Depth-First Search (IDDFS):

Input:
A graph represented by an adjacency matrix.
A start vertex and a target vertex.
For depth from 0 to number_of_vertices:
Create a visited array to track visited vertices for each iteration.
Call depthLimitedDFS(start_vertex, target_vertex, depth, visited):
If the target vertex is found, print the current depth and return.
Depth-Limited DFS Algorithm:
If the current vertex equals the target, return true (success).
If the depth limit is 0 or less, return false (stop the search).
Otherwise:
Mark the current vertex as visited.
For each neighbor of the current vertex, if it is not visited and there is an edge, call depthLimitedDFS recursively with a reduced depth limit.
If no depth limit finds the target, print "Target not found".
Explanation of Methods:
addEdge(int startVertex, int endVertex):

Adds an undirected edge between two vertices by updating the adjacency matrix.
performIDDFS(int startVertex, int targetVertex):

This method performs IDDFS by increasing the depth limit from 0 to the total number of vertices. It calls depthLimitedDFS for each depth limit.
depthLimitedDFS(int currentVertex, int targetVertex, int depthLimit, boolean[] visited):

Recursively performs DFS with a depth limit.
If the target is found at the current depth, it returns true.
It marks nodes as visited to avoid cycles and redundant checks.
Example Execution:
Suppose the graph has 4 vertices, with the following edges:

Copy code
1 - 2
1 - 3
2 - 4
The adjacency matrix will look like this:

Copy code
0 1 1 0
1 0 0 1
1 0 0 0
0 1 0 0
If you start from vertex 1 and target vertex 4, IDDFS will:

Start with depth limit 0, check if 1 is the target (no).
Increase the depth limit to 1, check vertices 1, 2, and 3.
Continue until it reaches depth 2 and finds the target vertex 4.
Key Points:
Time Complexity: IDDFS has a time complexity of 
𝑂
(
𝑏
𝑑
)
O(b 
d
 ), where 
𝑏
b is the branching factor (average number of neighbors per node) and 
𝑑
d is the depth of the solution. Since IDDFS performs a DFS for each depth limit, it is optimal in terms of space complexity compared to a full BFS.
Space Complexity: IDDFS only needs space proportional to the depth, 
𝑂
(
𝑑
)
O(d), which is more efficient than BFS, which requires space for all vertices in the queue.
This is a highly efficient algorithm for cases where the depth of the solution is unknown or large, and it avoids the memory overhead of traditional BFS. */