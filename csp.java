import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class cspppp {
    static Scanner sc = new Scanner(System.in);
    static ArrayList<Character> uniqueChars = new ArrayList<>();
    static HashMap<Character, Integer> charToDigitMap = new HashMap<>();
    static String s1, s2, s3;
    static boolean solutionFound = false;
/*Global Variables

Scanner sc: Used to read input from the user.
ArrayList<Character> uniqueChars: Stores unique characters found in the input strings.
HashMap<Character, Integer> charToDigitMap: Maps each unique character to a digit.
String s1, s2, s3: Stores the three input strings.
boolean solutionFound: Flag to check whether a valid solution has been found. */
    public static void main(String[] args) {
        System.out.println("Enter string 1:");
        s1 = sc.nextLine().toUpperCase();
        System.out.println("Enter string 2:");
        s2 = sc.nextLine().toUpperCase();
        System.out.println("Enter string 3:");
        s3 = sc.nextLine().toUpperCase();

        addUniqueCharacters(s1);
        addUniqueCharacters(s2);
        addUniqueCharacters(s3);
        
        calculate();
    }
    /*The user is prompted to input three strings, which are stored in s1, s2, and s3.
The addUniqueCharacters method is called for each string to extract all unique characters and store them in uniqueChars.
The calculate method is invoked to solve the problem. */

    public static void addUniqueCharacters(String s) {
        for (char c : s.toCharArray()) {
            if (!uniqueChars.contains(c)) {
                uniqueChars.add(c);
            }
        }
    }
/*This method loops through each character in the string s and adds it to the uniqueChars list if it's not already present. This ensures that only unique characters are stored. */
    public static void calculate() {
        if (uniqueChars.size() > 10) {
            System.out.println("No solution exists! More than 10 unique characters.");
            return;
        }

        int[] digits = new int[uniqueChars.size()];
        boolean[] used = new boolean[10];
        backtrack(digits, used, 0);

        if (!solutionFound) {
            System.out.println("No solution found!");
        }
    }
    /*Validation: If the number of unique characters exceeds 10, it's impossible to assign digits (since we only have digits from 0 to 9), so the program outputs a message and returns.
Backtracking Setup: Initializes the digits array (which will hold the digit assignments for the characters) and the used array (which tracks which digits have been assigned).
Backtracking Call: The backtrack method is called to begin the recursive search for a solution. */
    
    public static void backtrack(int[] digits, boolean[] used, int index) {
        if (index == uniqueChars.size()) {
            for (int i = 0; i < uniqueChars.size(); i++) {
                charToDigitMap.put(uniqueChars.get(i), digits[i]);
            }

            if (charToDigitMap.get(s1.charAt(0)) == 0 ||
                charToDigitMap.get(s2.charAt(0)) == 0 ||
                charToDigitMap.get(s3.charAt(0)) == 0) {
                return;
            }

            long num1 = getNumber(s1);
            long num2 = getNumber(s2);
            long num3 = getNumber(s3);

            if (num1 + num2 == num3) {
                solutionFound = true;
                System.out.println("Solution found:");
                System.out.println(s1 + " + " + s2 + " = " + s3);
                System.out.println(num1 + " + " + num2 + " = " + num3);
                System.exit(0); 
            }
            return;
        }
/*Base Case: When all characters have been assigned a digit (index == uniqueChars.size()), the program creates a mapping of characters to digits and checks if the first character in each string has a non-zero digit (leading zeros are not allowed). It then converts the strings into numbers using getNumber and checks if num1 + num2 == num3.
Recursive Case: The method tries all unused digits (from 0 to 9) and assigns them to the current character. After assigning a digit, it recursively proceeds to assign digits to the next character.
If a valid solution is found, the program outputs the solution and exits. */
        for (int digit = 0; digit < 10; digit++) {
            if (!used[digit]) {
                digits[index] = digit;
                used[digit] = true;
                backtrack(digits, used, index + 1);
                used[digit] = false; 
            }
        }
    }

    public static long getNumber(String s) {
        long number = 0;
        for (char c : s.toCharArray()) {
            number = number * 10 + charToDigitMap.get(c);
        }
        return number;
    }
    /*This method converts a string s into a number by looking up the digit corresponding to each character in the charToDigitMap. It builds the number digit by digit. */
}
/*
 * Algorithm
Input Phase:

Read the three input strings (s1, s2, s3).
Extract Unique Characters:

Loop through all three strings and extract the unique characters, storing them in a list (uniqueChars).
Backtracking Phase:

Base Case: When all unique characters have been assigned a digit, check if the mapping satisfies the equation num1 + num2 = num3. If so, print the solution and stop the recursion.
Recursive Case: Try all digits (from 0 to 9) for each character, ensuring that each digit is used only once. If a valid mapping is found, backtrack and check the next possible assignment.
Solution Check:

If a valid solution is found, print the corresponding strings and their numerical values. If no solution is found, print "No solution found".
Complexity Analysis
Time Complexity: The worst-case time complexity is O(10!) because the algorithm tries all permutations of digits for the unique characters. Since there are at most 10 unique characters, the factorial of 10 (10!) is the upper bound on the number of backtracking steps.
Space Complexity: The space complexity is O(n), where n is the number of unique characters. This is due to the space required for the uniqueChars list, digits array, and used array.
This approach efficiently handles the problem for small instances but may become impractical for larger input sizes with many unique characters.
 */