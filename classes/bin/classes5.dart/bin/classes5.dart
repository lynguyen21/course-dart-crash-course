// interface class
//  Interface class is used to defined behaviors (methods) that all of its sub-classes must provide all the implementation.

// extends allows a class to inherit from one superclass (single inheritance).
// It inherits both concrete and abstract methods and can override them if needed.

// implements requires a class to provide implementations for all the methods defined in the interface,
// regardless of whether they are already implemented.
// The method of the interfaces are called "contract" that the implemented class has to provide implementation

// Example 1: interface class and its sub-classes are in the same file

/// Interface class [A] with a method [sayHello]
interface class A {
  void sayHello() {
    print('A.sayHello');
  }
}

/// Sub-class [B] wants to extend interface class [A]
/// to add additional method [sing].
/// Instances of class [B] can use methods in both [A] and [B]
class B extends A {
  void sing() {
    print('B.sing: I am singing');
  }
}

/// Sub-class [C] wants to implement interface class [A]
/// to override the method [sayHello] using its own implementation.
/// Instances of class [C] MUST use its own version of method [sayHello].
class C implements A {
  @override
  void sayHello() {
    print('C.sayHello');
  }
}

abstract class AbstractInterface {
  void say(); // {}
}

class D implements AbstractInterface {
  @override
  void say() {
    print('D says');
  }
}

void main() {
  var a = A();
  a.sayHello(); // output: A.sayHello

  final b = B();
  b.sayHello(); // output: A.sayHello
  b.sing(); // output: B.sing: I am singing

  final c = C();
  c.sayHello(); // output: C.sayHello

    // Testing IsarStorage
  var isar = IsarStorage();
  isar.save('user1', 'John Doe');
  print(isar.load('user1'));
}

// Extends example:
// class Animal {
//   void eat() => print('Animal is eating');
// }

// class Dog extends Animal {
//   void bark() => print('Dog is barking');
// }

// void main() {
//   var dog = Dog();
//   dog.eat(); // Inherited from Animal
//   dog.bark(); // Dog's own method
// }

// Implement example:
// class Animal {
//   void eat() => print('Animal is eating');
// }

// class Dog implements Animal {
//   @override
//   void eat() => print('Dog is eating');

//   void bark() => print('Dog is barking');
// }

// void main() {
//   var dog = Dog();
//   dog.eat(); // Must implement its own version
//   dog.bark();
// }

// Example 2: interface class in one file and its sub-classes are in a different file.

// Library a.dart
interface class A {
    void greet() { ... }
}

// Library b.dart
import 'a.dart';

/// since A is a concrete interface class, it can have an instance
var instanceOfA = A();       // Can be constructed

/// Class [B] is in a different file with the interface [A],
/// - it cannot `extends` the class [A]
/// - it can `implement` the interface class [A]
class B extends A {  // ERROR: Cannot be inherited
    int instanceMember;
    // ...
}

/// Class [C] is in a different file with the interface [A],
/// - it cannot extends the class [A]
/// - it can implement the interface class [A]
class C implements A {  // Can be implemented
    @override
    void greet() { ... }
}

// Example 3: interface class requires outside library's sub-classes provide their implementation for all methods defined in the interface

// abstract -> can extend and implement
// interface -> can construct and implement
// abstract interface -> can only implement
/// Define abstract interface class [Storage]
/// and require all sub-classes to implement all the methods [save] and [load]
abstract interface class Storage {
    void save(String key, String value);
    String load(String key);
}

/// Outside of Library
class IsarStorage implements Storage {
    @override
    String load(String key) => 'data loaded from $key';

    @override
    void save(String key, String value) => '$value saved to $key';
}

/// Error!
/// The [save] method must be implemented.
// class HiveStorage extends Storage {
//     @override
//     String load(String key) => 'data loaded from $key';

    // Where is the save method? You should implement this class!!
