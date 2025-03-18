// Limiting Mixins to Data Types
// By using on keyword, you can specify that a mixin can only be applied to classes that meet certain type requirements

class Animal {
  String name;
  Animal(this.name);
}

mixin Logger on Animal {
  void log() {
    print('Logging: ${this.name}');
  }
}

class Dog extends Animal with Logger {
  Dog(String name) : super(name);
}

void main() {
  var dog = Dog('Buddy');
  dog.log(); // ✅ Works because Dog extends Animal and mixes Logger

  // var animal = Animal('Lion');
  // animal.log(); // ❌ Error: Animal does not have log()
  // // Only subclasses of Animal can mix Logger in
}
