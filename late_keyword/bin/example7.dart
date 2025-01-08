//Deferred Initialization

class Example {
  late String description;

  void initialize() {
    description = "This is initialized later.";
  }

  void printDescription() {
    print(
        description); // Will throw an error if accessed before initialize() is called
  }
}

void main() {
  final example = Example();
  example.initialize();
  example.printDescription(); // Output: This is initialized later.
}
