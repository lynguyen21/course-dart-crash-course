import 'dart:vmservice_io';

// /// The [Person] class represents a person with a name and an age.
// class Person {
//   final String name;
//   final int age;

//   /// Constructs a new instance of the [Person] class.
//   ///
//   /// The [name] parameter is required and represents the name of the person.
//   /// The [age] parameter is required and represents the age of the person.
//   const Person({required this.name, required this.age});

//   /// Displays the information of the person.
//   void displayInfo() {
//     print('Name: $name');
//     print('Age: $age');
//   }
// }

// /// The [Student] subclass represents a student who is also a person and has a major.
// class Student extends Person {
//   /// Student class has an additional field [major].
//   final String major;

//   /// Constructs a [Student] object with the given [name], [age], and [major].
//   ///
//   /// This uses the new way of referring to the parent's fields
//   /// directly with `super.name` and `super.age`.
//   Student({required super.name, required super.age, required this.major});

//   /// Alternative old way of creating a constructor, explicitly calling the parent's constructor:
//   /// ```dart
//   /// Student({required String name, required int age, required this.major})
//   ///     : super(name: name, age: age);
//   /// ```

//   /// Displays the student's information, including the major.
//   @override
//   void displayInfo() {
//     super.displayInfo();
//     print('Major: $major');
//   }
// }

// // @override
// // This explicitly indicates that displayInfo() in the Student class overrides the method from Person.
// // Ensures that the method signature matches the parent's method exactly.
// // Helps catch mistakes if the method is renamed or its parameters change.

// // 'super' refers to the instance of the parent class (Person).

// /// Main function to demonstrate the functionality.
// void main() {
//   // Student student = Student(name: 'Alice', age: 20, major: 'Computer Science');
//   // student.displayInfo();

//   Professor professor1 = Professor(age: 60, name: 'Kerr', rate: 1);
//   professor1.displayInfo();
// }

// // The parent class Person only knows about name and age, but the subclass Student adds major.
// // By overriding displayInfo(), we ensure that the base class functionality is preserved (name & age)
// // while also adding new behavior (major).

// class Professor extends Person {
//   final int rate;

//   const Professor({
//     required super.age,
//     required super.name,
//     required this.rate,
//   });

//   @override
//   void displayInfo() {
//     super.displayInfo();
//     print('Rate: $rate');
//   }
// }

// Redirect constructor:

class Point {
  double x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
  Point.alongYAxis(double y) : this(0, y);

  // Method to display point coordinates
  void display() {
    print('Point($x, $y)');
  }
}

void main() {
  Point p1 = Point(3, 4);
  Point p2 = Point.alongXAxis(5);
  Point p3 = Point.alongYAxis(7);

  // Print the points
  p1.display(); // Output: Point(3.0, 4.0)
  p2.display(); // Output: Point(5.0, 0.0)
  p3.display(); // Output: Point(0.0, 7.0)
}
