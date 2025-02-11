/// The [Person] class represents a person with a name and an age.
class Person {
  final String name;
  final int age;

  /// Constructs a new instance of the [Person] class.
  ///
  /// The [name] parameter is required and represents the name of the person.
  /// The [age] parameter is required and represents the age of the person.
  const Person({required this.name, required this.age});

  /// Displays the information of the person.
  void displayInfo() {
    print('Name: $name');
    print('Age: $age');
  }
}

/// The [Student] subclass represents a student who is also a person and has a major.
class Student extends Person {
  /// Student class has an additional field [major].
  final String major;

  /// Constructs a [Student] object with the given [name], [age], and [major].
  ///
  /// This uses the new way of referring to the parent's fields
  /// directly with `super.name` and `super.age`.
  Student({required super.name, required super.age, required this.major});

  /// Alternative old way of creating a constructor, explicitly calling the parent's constructor:
  /// ```dart
  /// Student({required String name, required int age, required this.major})
  ///     : super(name: name, age: age);
  /// ```

  /// Displays the student's information, including the major.
  @override
  void displayInfo() {
    super.displayInfo();
    print('Major: $major');
  }
}

/// Main function to demonstrate the functionality.
void main() {
  Student student = Student(name: 'Alice', age: 20, major: 'Computer Science');
  student.displayInfo();
}
