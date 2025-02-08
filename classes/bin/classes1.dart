// Classes in Dart
// Ideas:
// In Dart, classes are a fundamental building block for creating objects and organizing code.
// They provide a way to define the structure and behavior of objects and enable you to create multiple Simple Classinstances of a particular type.
// Simple class:
// void main(List<String> args) {
//   /// Create a new instance of a Person.
//   /// Person class represents a person with a name and age. It has two fields: [name] of type [String] and [age] of type [int]
//   final person1 = Person(name: 'John', age: 20);
//   // Print the person's details
//   print('Name: ${person1.name}, Age: ${person1.age}');
// }

// /// Represents a person with a name and age.
// /// The class has a constructor Person({required this.name, required this.age})
// /// which takes two required named parameters: name and age.
// class Person {
//   /// Constructs a new instance of the [Person] class.
//   /// The [name] parameter is required and represents the name of the person.
//   /// The [age] parameter is required and represents the age of the person.
//   /// These parameters are used to initialize the name and age fields of the
//   /// Person object
//   const Person({required this.name, required this.age});
//   final String name;
//   final int age;
// }
// Default constructor
// // If a class doesn’t explicitly define a constructor, Dart provides a default constructor with no parameters.
// class DefaultConstructorExample {
//   String message = "This is a default constructor";

//   // No explicit constructor is defined, so Dart provides a default one.
// }

// void main() {
//   final obj = DefaultConstructorExample();
//   print(obj.message); // Output: This is a default constructor
// }

// // Unnamed Constructor (Normal Constructor)
// class Person {
//   /// Normal constructor or Unnamed constructor with fields [name] and [age] as parameters.
//   /// Since fields name and age are final, [const] can be used with the constructor.
//   /// The field [name] is required, it cannot have default value,
//   /// The field [age] is not required, it can have default value.
//   /// Example usage:
//   /// ```dart
//   /// final person = Person(name: 'John Doe', age: 25);
//   /// ```
//   const Person({required this.name, this.age = 10});

//   /// Constructs a new instance of the [Person] class with a predefined name 'Foo' and age 20.
//   ///
//   /// This constructor creates a constant instance of the [Person] class with the name 'Foo'
//   /// and age 20. The [name] field is initialized with the value 'Foo', and the [age] field is
//   /// initialized with the value 20.
//   const Person.foo() : name = 'Foo', age = 20;
//   final String name;
//   final int age;
// }

// // Unnamed constructor with some fields as parameters, some with pre-defined values
// class Person {
//   /// Normal constructor or Unnamed constructor with fields [name]  parameters and pre-defined value for field [age]
//   /// Since fields name and age are final, [const] can be used with the constructor.
//   /// The field [name] is required, it cannot have default value,
//   /// The field [age] has pre-defined value = 10
//   /// Example usage:
//   /// ```dart
//   /// final person = Person(name: 'John Doe');
//   /// ```
//   /// the person will have the default age = 10
//   const Person({required this.name}) : age = 10;
// }

// // Named Constructor
// // To support multiple constructors for a class, Dart allows constructor has different names,
// // thus called named constructors.

// class Person {
//   /// Named constructor [foo]: The constructor with named [foo]
//   /// to create an instance of the [Person] class with the predfined [age] of 10.
//   /// It accepts one positional parameter [name].
//   ///
//   /// Example usage:
//   /// ```dart
//   /// final person = Person.foo('John Doe');
//   /// ```
//   /// the person will have the default age = 10
//   const Person.foo(this.name) : age = 10;

//   /// Named constructor [bar]: The constructor with named [bar]
//   /// to create an instance of the [Person] class with the
//   /// predfined [name] of value 'Mr. A'.
//   /// It accepts the named parameter [age].
//   ///
//   /// Example usage:
//   /// ```dart
//   /// final person = Person.bar(age: 30);
//   /// ```
//   /// the person will have the default name as 'Mr. A'
//   const Person.bar({required this.age}) : name = 'Mr. A';

//   final String name;
//   final int age;
// }

// // summary
// // Named Constructor
// Person.foo(this.name) : age = 10;
// Person.foo() : name = 'Foo', age = 20;
// // Unnamed constructor
// Person(this.name, this.age);

// Factory constructor
// A special type of constructor that can be used to create objects in a flexible manner.
// Usage:

// It allows you to control the object creation process by providing custom logic,
// It allows you to possibly create a different object or an object of a sub-class,
// It allows you to cache the instance of objects
// Examples:
// Create an instance of a sub-class and controlling the object creation by providing some custom logic.

import 'dart:vmservice_io';

/// Define an abstract class Vehicle.
/// Using abstract class to prevent users from creating
/// an instance of [Vehicle] class.
// abstract class Vehicle {
//   final int numberOfWheel;
//   const Vehicle({required this.numberOfWheel});

//   /// Factory constructor to create an instance of its sub-class Car
//   factory Vehicle.car() => Car();

//   /// Factory constructor to create an instance of its sub-class Bike
//   factory Vehicle.bike() => Bike();

//   /// Conditionally create an instance of its sub-classes
//   /// based on the value of the given parameter [noWheel]
//   factory Vehicle.general({required int noWheel}) {
//     return switch (noWheel) {
//       2 => Bike(),
//       4 => Car(),
//       _ => UnknownVehicle(),
//     };
//   }
// }

// // general is a named factory constructor of the Vehicle class.
// // It does not directly create an instance of Vehicle, but instead returns an instance of one of its subclasses (Bike, Car, or UnknownVehicle).
// class Car extends Vehicle {
//   const Car() : super(numberOfWheel: 4);
// }

// // Car inherits from Vehicle, meaning it has access to all the public properties and methods of Vehicle.
// // The keyword extends is used to create a subclass.

// // super(...) is used to call the constructor of the parent class (Vehicle).
// // Here, it passes the value 4 to the numberOfWheel parameter of Vehicle's constructor.
// class Bike extends Vehicle {
//   const Bike() : super(numberOfWheel: 2);
// }

// void main(List<String> args) {
//   print(Vehicle.car());
//   print(Vehicle.bike());
// }

// abstract class Vehicle {
//   final int numberOfWheel;
//   const Vehicle({required this.numberOfWheel});

//   factory Vehicle.car() => Car();
//   factory Vehicle.bike() => Bike();

//   factory Vehicle.general({required int noWheel}) {
//     return switch (noWheel) {
//       2 => Bike(),
//       4 => Car(),
//       _ => UnknownVehicle(),
//     };
//   }
// }

// class Car extends Vehicle {
//   const Car() : super(numberOfWheel: 4);
// }

// class Bike extends Vehicle {
//   const Bike() : super(numberOfWheel: 2);
// }

// void main(List<String> args) {
//   print(Vehicle.bike());
//   print(Vehicle.car());
// }

void main(List<String> args) {
  print(Vehicle.car());
  print(Vehicle.bike());
}

/// Define an abstract class Vehicle.
/// Using abstract class to prevent users from creating
/// an instance of [Vehicle] class.
abstract class Vehicle {
  final int numberOfWheel;
  const Vehicle({required this.numberOfWheel});

  /// Factory constructor to create an instance of its sub-class Car
  factory Vehicle.car() => Car();

  /// Factory constructor to create an instance of its sub-class Bike
  factory Vehicle.bike() => Bike();

  /// Conditionally create an instance of its sub-classes
  /// based on the value of the given parameter [noWheel]
  factory Vehicle.general({required int noWheel}) {
    return switch (noWheel) {
      2 => Bike(),
      4 => Car(),
      _ => UnknownVehicle(),
    };
  }
}

class Car extends Vehicle {
  const Car() : super(numberOfWheel: 4);
}

class Bike extends Vehicle {
  const Bike() : super(numberOfWheel: 2);
}

class UnknownVehicle extends Vehicle {
  const UnknownVehicle() : super(numberOfWheel: _);
}
