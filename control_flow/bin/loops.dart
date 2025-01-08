// 1. For Loop: Used when the number of iterations is known.
/* void main(List<String> args) {
  for (int i = 0; i < 5; i++) {
    print("Count: $i");
  }
} */

// 2. For-in Loop: Used for iterating over items in a collection like a list.
/* void main(List<String> args) {
  List<String> fruits = ['Apple', 'Banana', 'Cherry'];
  for (var fruit in fruits) {
    print(fruit);
  }
} */

// 3. While Loop: Executes a block of code while a condition is true. The condition is checked before each iteration.
/* void main(List<String> args) {
  int count = 0;
  while (count < 5) {
    print("Count: $count");
    count++;
  }
} */

// 4. Do-While Loop: Similar to the while loop, but the condition is checked after each iteration, ensuring the code runs at least once.
void main(List<String> args) {
  int count = 0;
  do {
    print("Count: $count");
    count++;
  } while (count < 5);
}
