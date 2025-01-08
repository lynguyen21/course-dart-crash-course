// Control Flow Operators

// 1. Break: Immediately exits the nearest enclosing loop or switch statement.
/* void main(List<String> args) {
  for (int i = 0; i < 5; i++) {
    if (i == 3) break;
    print("Count: $i");
  }
} */

// 2. Continue: Skips the current iteration and proceeds to the next iteration of the loop.
void main(List<String> args) {
  for (int i = 0; i < 5; i++) {
    if (i == 2) continue;
    print("Count: $i");
  }
}
