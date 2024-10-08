# Notes on the course

## Late keyword

THe `late` keyword is used to indicate that a variable initialization will be deferred until it is accessed for the first time. This is useful when the initial value of the variable is not available at the time of declaration or when initializing the variable is expensive and we want to delay until it is needed.

### Example:

**With non nullable types**

```
late String name;

void initialize() {
  name = 'John Doe';
}

void printName() {
  print(name); // The variable will only be initialized before this point.
}

void main() {
  initialize();
  printName();
}
```
**Lazy Initialization**

The variable will only be initialized when it is accessed, which can be efficient for variables whose initialization is resource-intensive.

```
late int expensiveCalculation = performExpensiveCalculation();

int performExpensiveCalculation() {
  print("Performing expensive calculation...");
  return 42; // Example of an expensive result
}

void main() {
  print("Before accessing the variable...");
  print(expensiveCalculation); // The calculation happens here.
}
```
