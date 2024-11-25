import java.util.*;

class Node implements Comparable<Node> {
    public final String value;
    public double gScore;
    public final double hScore;
    public double fScore;
    public Node parent;
    public final List<Edge> neighbors;

    public Node(String value, double hScore) {
        this.value = value;
        this.hScore = hScore;
        this.gScore = Double.MAX_VALUE;
        this.fScore = Double.MAX_VALUE;
        this.neighbors = new ArrayList<>();
    }

    public void addNeighbor(Node neighbor, double weight) {
        neighbors.add(new Edge(this, neighbor, weight));
    }

    @Override
    public int compareTo(Node other) {
        return Double.compare(this.fScore, other.fScore);
    }
}

class Edge {
    public final Node from;
    public final Node to;
    public final double weight;

    public Edge(Node from, Node to, double weight) {
        this.from = from;
        this.to = to;
        this.weight = weight;
    }
}

public class AStarAlgorithm {
    public static List<Node> aStar(Node start, Node goal) {
        PriorityQueue<Node> openSet = new PriorityQueue<>();
        Set<Node> closedSet = new HashSet<>();

        start.gScore = 0;
        start.fScore = start.hScore;
        openSet.add(start);

        while (!openSet.isEmpty()) {
            Node current = openSet.poll();

            if (current.equals(goal)) {
                return reconstructPath(current);
            }

            closedSet.add(current);

            for (Edge edge : current.neighbors) {
                Node neighbor = edge.to;

                if (closedSet.contains(neighbor)) {
                    continue;
                }

                double tentativeGScore = current.gScore + edge.weight;

                if (tentativeGScore < neighbor.gScore) {
                    neighbor.parent = current;
                    neighbor.gScore = tentativeGScore;
                    neighbor.fScore = neighbor.gScore + neighbor.hScore;

                    if (!openSet.contains(neighbor)) {
                        openSet.add(neighbor);
                    }
                }
            }
        }

        return null;
    }

    private static List<Node> reconstructPath(Node current) {
        List<Node> path = new ArrayList<>();
        while (current != null) {
            path.add(current);
            current = current.parent;
        }
        Collections.reverse(path);
        return path;
    }

    public static void main(String[] args) {
        Node start = new Node("A", 6);
        Node b = new Node("B", 9);
        Node c = new Node("C", 4);
        Node d = new Node("D", 3);
        Node e = new Node("E", 2);
        Node f = new Node("F", 1);
        Node h = new Node("H", 7);
        Node i = new Node("I", 7);
        Node k = new Node("K", 9);
        Node goal = new Node("X", 0);

        start.addNeighbor(b, 3);
        start.addNeighbor(c, 3);
        start.addNeighbor(h, 4);
        start.addNeighbor(i, 6);
        b.addNeighbor(d, 5);
        b.addNeighbor(e, 4);
        b.addNeighbor(d, 5);
        c.addNeighbor(k, 11);
        c.addNeighbor(e, 2);
        d.addNeighbor(d, 13);
        d.addNeighbor(f, 2);
        e.addNeighbor(goal, 1);
        e.addNeighbor(f, 4);
        f.addNeighbor(goal, 7);
        k.addNeighbor(goal, 3);

        List<Node> path = aStar(start, goal);

        if (path != null) {
            System.out.println("Path found:");
            for (Node node : path) {
                System.out.print(node.value + " ");
            }
        } else {
            System.out.println("No path found.");
        }
    }
}

/*
 * Explanation:
 * Node Class:
 * 
 * Represents a node in the graph.
 * Contains a value, gScore (cost from start to this node), hScore (heuristic
 * estimate from this node to the
 * goal), and fScore (gScore + hScore).
 * Holds a list of neighbors and the parent node to reconstruct the path.
 * Edge Class:
 * 
 * Represents an edge between two nodes with a specific weight (cost).
 * AStarAlgorithm Class:
 * 
 * Implements the A* search algorithm.
 * Uses a priority queue (openSet) to explore nodes, always expanding the node
 * with the lowest fScore.
 * The closedSet contains nodes that have already been explored.
 * The aStar method returns the path from the start node to the goal node.
 * Heuristics:
 * 
 * The hScore is the heuristic function, an estimate of the cost to reach the
 * goal from a node.
 * In this example, heuristic values are hardcoded for simplicity.
 * Execution:
 * When you run the code, it searches for the shortest path from the start node
 * to the goal node using the A*
 * algorithm. The main method provides a simple example graph, and the output
 * shows the nodes in the path found
 * by the algorithm.
 */
/*Detailed Explanation of the Code
This Java code implements the A algorithm* for pathfinding in a graph. The algorithm efficiently finds the shortest path from a start node to a goal node by combining the actual distance traveled and an estimate of the remaining distance to the goal. Here's a breakdown of each part of the code:

Classes Explanation
Node Class:

Represents a node (or vertex) in the graph. Each node has:
value: A unique identifier for the node (e.g., "A", "B", "X").
gScore: The cost to reach this node from the start node. Initially, it's set to infinity for all nodes except the start node.
hScore: The heuristic estimate of the cost to reach the goal node from this node. In this code, it's predefined for each node.
fScore: The total estimated cost, which is the sum of gScore and hScore (i.e., fScore = gScore + hScore).
parent: A reference to the parent node used to reconstruct the optimal path once the goal is reached.
neighbors: A list of neighboring nodes that are directly connected by edges. Neighbors are added with specific edge weights.
Methods in Node Class:

addNeighbor(Node neighbor, double weight): Adds an edge (with a specified weight) from the current node to a neighboring node.
compareTo(Node other): Compares nodes based on their fScore. This is used to prioritize nodes in the priority queue (openSet), so the node with the lowest fScore gets explored first.
Edge Class:

Represents an edge (or connection) between two nodes. It contains:
from: The source node.
to: The destination node.
weight: The cost (or distance) to travel from the from node to the to node.
AStarAlgorithm Class:

Implements the A* algorithm. It contains the core logic to find the shortest path in the graph.
Methods in AStarAlgorithm Class:

aStar(Node start, Node goal): This is the main function of the A* algorithm. It uses a priority queue (openSet) to explore nodes with the lowest fScore first. The process continues until the goal node is reached or all nodes are explored.
Initializes the start node’s gScore and fScore.
Iteratively explores the node with the smallest fScore from the openSet.
For each of its neighbors, it calculates the tentative gScore, updates the node’s parent and scores, and adds it to the openSet if necessary.
If the goal is found, it calls reconstructPath to trace back the optimal path.
reconstructPath(Node current): This function backtracks from the goal node to the start node using the parent references and constructs the path.
Main Method:

Creates a simple graph of nodes with predefined heuristic values and edges.
Calls aStar(start, goal) to find the path from the start node to the goal node.
Prints the path if found, or indicates if no path exists.
A Algorithm Theory Concepts*
The A algorithm* is a well-known search algorithm used to find the shortest path between nodes in a graph. It combines elements of both Dijkstra's Algorithm (which is focused on finding the shortest path from a start node) and Greedy Best-First Search (which uses a heuristic to estimate the distance to the goal). A* achieves this by using a cost function 
𝑓
(
𝑛
)
=
𝑔
(
𝑛
)
+
ℎ
(
𝑛
)
f(n)=g(n)+h(n), where:

g(n) is the actual cost from the start node to the current node.
h(n) is the heuristic estimate of the cost from the current node to the goal.
f(n) is the total estimated cost of the cheapest solution through the current node, used to prioritize which node to explore next.
Key Concepts:
Priority Queue (openSet): The open set is implemented as a priority queue (using the fScore) to explore nodes with the lowest total cost (fScore) first.

Heuristic (hScore): The heuristic is an estimate of the remaining cost to reach the goal from a given node. Common heuristics include:

Manhattan Distance for grids.
Euclidean Distance for continuous spaces.
gScore: This is the exact cost of the shortest path from the start node to the current node, calculated as the sum of the edge weights.

fScore: The sum of gScore and hScore provides a total estimate of the shortest possible path from the start to the goal through the current node.

Reconstructing the Path: After reaching the goal node, the algorithm traces the path back to the start node by following the parent nodes.

Algorithm (Step-by-Step)
Input:
Graph: A set of nodes and weighted edges.
Start Node: The node where the pathfinding starts.
Goal Node: The destination node.
Output:
Path: A list of nodes from the start node to the goal node that forms the shortest path.
If no path exists, return null.
Steps:
Initialization:

Set the gScore of the start node to 0 (no cost to reach itself).
Set the fScore of the start node to its hScore (estimated cost to the goal).
Add the start node to the open set.
Main Loop:

While the open set is not empty:
Select the node (current) with the lowest fScore from the open set.

If current is the goal, call reconstructPath(current) and return the path.

Add current to the closed set (this node has been fully explored).

For each neighbor of current:

Skip neighbors that are in the closed set.
Calculate the tentative gScore for the neighbor: 
tentative gScore
=
current.gScore
+
edge.weight
tentative gScore=current.gScore+edge.weight.
If the neighbor is not in the open set or the tentative gScore is better than the current gScore of the neighbor:
Update the gScore and fScore for the neighbor.
Set the parent of the neighbor to the current node.
If the neighbor is not in the open set, add it.
Path Reconstruction:

Starting from the goal node, trace back through the parent nodes until the start node is reached, building the path.
Termination:

If the goal is reached, return the reconstructed path.
If the open set is empty and the goal is not reached, return null (no path exists).
Time and Space Complexity
Time Complexity: 
𝑂
(
𝐸
log
⁡
𝑉
)
O(ElogV), where 
𝐸
E is the number of edges and 
𝑉
V is the number of nodes. This is due to the priority queue operations (add, poll) and the need to explore each edge.

Space Complexity: 
𝑂
(
𝑉
+
𝐸
)
O(V+E), since we store nodes in the open and closed sets and edges in the neighbors list.

Example Execution
Given the following graph (nodes and edges):

scss
Copy code
    A(6) --3--> B(9) --4--> E(2) --1--> X(0)
     |         |        |        |
     3         5        4        7
     |         |        |        |
     C(4) --2--> K(9) --3--> F(1) 
     |   
    11
     | 
     D(3)
Start: "A", Goal: "X"
Path Found: A -> B -> E -> X (Shortest path based on gScore + hScore).
Output:

less
Copy code
Path found:
A B E X 





 */