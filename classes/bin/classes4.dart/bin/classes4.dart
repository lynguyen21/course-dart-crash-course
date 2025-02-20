//  Getter and Setter

// Getter

// Getters are methods normally to get or read properties of an object (an instance of a class).

// It is in the format as ReturnType get methodName() {}

class Person {
  String firstname;
  String lastname;

  Person({required this.firstname, required this.lastname});

  String get fullName => '$firstname $lastname';
}

class Education {
  String school;
  String schoolname;

  Education({required this.school, required this.schoolname});

  String get schoolName => '$school $schoolname';
}

// void main(List<String> args) {
//   Person person = Person(firstname: 'Ly', lastname: 'Nguyen');
//   print('Person: ${person.fullName}');

//   Animal animal = Animal(3.0);
//   print('Dog: ${animal._height}');

//   Education school1 = Education(school: 'University', schoolname: 'A');
//   print('School: ${school1.schoolName}');
// }

class Animal {
  /// Defines a private field [_height] using the underscore prefix.
  final double _height;

  /// Constructor to initialize [_height].
  Animal(this._height);

  /// Getter for [_height].
  double get height => _height;
}

// Setters

// Setters are also called Mutators, they are used to mutate the state of an object. Values of all the fields are formed as the state of an object.

// Setters are methods normally to set value for non final fields of an object (an instance of a class).

// In the case of a final field, its value must be defined in the class's constructor.
// It is in the format as set methodName(DataType value) {}

class Car {
  int _speed = 0; // Private field to store the car's speed
  // _speed is a private variable (denoted by the _ prefix), meaning it cannot be accessed directly outside the class.
  // /Getter
  int get speed => _speed;

  /// Setter
  set tocdo(int newSpeed) {
    if (newSpeed < 0) {
      throw Exception('Speed cannot be negative');
    } else {
      _speed = newSpeed;
    }
  }
}

class Bike {
  int _bikespeed = 0;
  int get speed => _bikespeed;

  set bikespeed(int newBikeSpeed) {
    if (newBikeSpeed < 0) {
      throw Exception('wrong value');
    } else {
      _bikespeed = newBikeSpeed;
    }
  }
}

class Student {
  int _grade = 0;
  int get grade => _grade;

  set grade(int studentGrade) {
    if (studentGrade < 0) {
      throw Exception('wrong value');
    } else {
      _grade = studentGrade;
    }
  }
}

// This setter allows controlled modification of _speed.
// If newSpeed is negative, it throws an Exception to prevent invalid values.
// Otherwise, _speed is updated with newSpeed.

void main() {
  // Car car = Car(); // Create a new Car instance
  // // print(car.speed); // Output: 0 (default speed)

  // car.tocdo = -50; // Set speed to 50
  // print(car.speed); // Output: 50 getter

  // car.speed = -10; //  Throws an exception: "Speed cannot be negative"

  Bike bike = Bike();
  bike.bikespeed = 30;
  print(bike.speed);

  Student student1 = Student();
  student1.grade = 5;
  print(student1.grade);

  Motor motor1 = Motor();
  print(motor1);

  Vehicle vehicle = Vehicle(wheelCount: 2);
  print(vehicle);
}

class Vehicle {
  final int wheelCount;

  const Vehicle({required this.wheelCount});

  @override
  String toString() {
    return '$runtimeType with $wheelCount wheels';
  }
}

class Motor extends Vehicle {
  const Motor() : super(wheelCount: 2);
}
