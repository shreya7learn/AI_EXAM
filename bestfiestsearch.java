import java.util.*;

class GreedyBestFirstSearchNumbers {
    static class Node implements Comparable<Node> {
        int id;
        int heuristic;

        Node(int id, int heuristic) {
            this.id = id;
            this.heuristic = heuristic;
        }

        @Override
        public int compareTo(Node other) {
            return Integer.compare(this.heuristic, other.heuristic);
        }
    }
/*Node Class:
Each Node object holds the id (the node's identifier) and the heuristic value (which indicates how close the node is to the goal).
The compareTo method ensures that nodes with smaller heuristic values have higher priority in the priority queue. */
    static Map<Integer, List<Integer>> graph = new HashMap<>();
    static Map<Integer, Integer> heuristics = new HashMap<>();
/*Graph Representation:
The graph is represented as a map of nodes to their neighbors.
The heuristics map stores the heuristic values for each node, provided by the user. */
    public static void greedyBestFirstSearch(int start, int goal) {
        PriorityQueue<Node> openList = new PriorityQueue<>();
        Set<Integer> visited = new HashSet<>();
        openList.add(new Node(start, heuristics.get(start)));

        System.out.println("Exploring path: ");
        while (!openList.isEmpty()) {
            Node current = openList.poll();
            if (visited.contains(current.id)) {
                continue;
            }

            System.out.println(current.id);
            visited.add(current.id);

            if (current.id == goal) {
                System.out.println("Goal reached: " + goal);
                return;
            }

            for (int neighbor : graph.getOrDefault(current.id, new ArrayList<>())) {
                if (!visited.contains(neighbor)) {
                    openList.add(new Node(neighbor, heuristics.get(neighbor)));
                }
            }
        }
        System.out.println("Goal not reachable.");
    }
/*Greedy Best-First Search (GBFS):
The main algorithm is implemented in the greedyBestFirstSearch function, which uses a priority queue to explore the nodes based on their heuristic values.
The openList priority queue stores Node objects with the node's id and heuristic value, ensuring the node with the lowest heuristic is explored first.
The visited set ensures that nodes are not re-explored. */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the number of nodes: ");
        int nodes = scanner.nextInt();

        System.out.print("Enter the number of edges: ");
        int edges = scanner.nextInt();

        System.out.println("Enter the edges (format: from to):");
        for (int i = 0; i < edges; i++) {
            int from = scanner.nextInt();
            int to = scanner.nextInt();

            graph.putIfAbsent(from, new ArrayList<>());
            graph.get(from).add(to);
        }

        System.out.println("Enter heuristic values for each node (format: node value):");
        for (int i = 0; i < nodes; i++) {
            int node = scanner.nextInt();
            int heuristic = scanner.nextInt();
            heuristics.put(node, heuristic);
        }

        System.out.print("Enter the start node: ");
        int start = scanner.nextInt();
        System.out.print("Enter the goal node: ");
        int goal = scanner.nextInt();

        // Perform the search
        greedyBestFirstSearch(start, goal);

        scanner.close();
    }
}
/*User Input:

The program prompts the user for the number of nodes, edges, and the start/goal nodes, and also reads the heuristic values for each node.
Running the Algorithm:

The main method handles user input and starts the Greedy Best-First Search with the specified start and goal nodes. */
/*Concepts and Components Used
Best Case Time Complexity: O(V log V) (when the goal is found early and very few nodes are processed).
Worst Case Time Complexity: O(E log V) (when every node and edge is processed).
Space Complexity: O(V + E) for the graph, plus O(V) for the priority queue and visited set.
Greedy Best-First Search (GBFS):

Greedy Best-First Search is an algorithm that expands nodes based on the heuristic values, which represent an estimate of the cost to reach the goal from that node.
It greedily selects the node with the smallest heuristic value to explore next, without considering the cost accumulated so far (unlike A Search*).
Node Class:

A Node class is used to represent each node in the graph. It contains:
id: The unique identifier for the node.
heuristic: The heuristic value of the node, which is used to decide which node to expand next.
The compareTo method is implemented to allow the priority queue to sort nodes based on their heuristic values.
Priority Queue:

A priority queue (openList) is used to explore the nodes. This ensures that the node with the smallest heuristic value is always explored first. The queue automatically handles the sorting based on the heuristic value due to the compareTo method.
Graph Representation:

The graph is represented as a map (graph), where each key is a node and the value is a list of neighboring nodes. The graph is created dynamically based on the user's input.
The heuristic values for each node are stored in another map (heuristics), which is also provided by the user.
Exploration Logic:

The algorithm starts from the start node and explores neighbors of each node by expanding the node with the smallest heuristic value. This continues until either:
The goal node is reached.
All reachable nodes are visited and the goal is not found.
Algorithm for Greedy Best-First Search (GBFS)
Here’s the step-by-step algorithm based on the code:

Input:

Read the number of nodes and edges in the graph.
Read the edges of the graph. Each edge is represented as a pair of nodes (from, to).
Read the heuristic value for each node.
Read the start node and the goal node.
Initialization:

Create a priority queue (openList) to store the nodes to be explored, ordered by their heuristic values.
Create a visited set (visited) to keep track of nodes that have already been explored.
Add the start node to the priority queue with its associated heuristic value.
Exploration:

While the priority queue is not empty:
Remove the node with the smallest heuristic value from the queue.
If the node has already been visited, skip it.
Print the current node’s id.
If the current node is the goal, print the success message and stop.
For each unvisited neighbor of the current node, add it to the priority queue with its heuristic value.
Goal Check:

If the goal node is found during the exploration, the algorithm terminates and outputs the path.
If the priority queue is empty and the goal node has not been found, output "Goal not reachable". */