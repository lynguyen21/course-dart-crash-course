// Private constructor

// If you don't want anyone creates an instance of a class, then you can create a private constructor as ClassName._().

// User can't call the private constructor externally.

// Usage:

// You want to create a singleton (single instance of a class)

// You can make a named contructor as private by having prefix _ before its name, for example _foo()

class SingletonClass {
  String name;

  SingletonClass._namedConstructor(
    this.name,
  ); // _name: private name constructor
  static final SingletonClass instance = SingletonClass._namedConstructor('Ly');
}

void main(List<String> args) {
  SingletonClass instance1 = SingletonClass.instance;
  print(instance1.name);

  Human human1 = Human(name: 'Ly');
  print(human1.name);
  human1.say('quoc');
  human1.say('Uyen');
  Human human2 = Human(name: 'Ly');
  human2.say('Quoc');

  Person person1 = Person.other();
  print('Person1: Name: ${person1.name}, Age: ${person1.age}');

  Person person2 = Person.other(name: 'Uyen', age: 3);
  print('Person2: Name: ${person2.name}, Age: ${person2.age}');
}

// class Human {
//   String name;

//   Human({required this.name});

//   void saying(String content) {
//     print('hello $content');
//   }
// }

class Human {
  String name; // property

  Human({required this.name});

  /// @param name of the function
  void say(String humanName) {
    print('Hello $humanName');
  }
}

void run(int distance) {
  print('Run $distance km');
}

// Optional parameter

// parameters to the constructor can be optional.

// if a field does not have late keyword, then its value must be pre-defined.

// == means if equal. x == y : check if x is equal to y or not. x == y is a boolean
// = means assignment. x = y means assign value y to x
// x = 3 means assign 3 to x
// class Person {
//   final String name;
//   final int age;

//   // Person.other({String? name, int? age}) {
//   //   if (name != null) {
//   //     this.name = name;
//   //   } else {
//   //     this.name = 'Mr.A';
//   //   }
//   //   if (age != null) {
//   //     this.age = age;
//   //   } else {
//   //     this.age = 30;
//   //   }
//   // }

//   const Person.other({
//       String? name,
//       int? age,
//   }): name = name ?? 'Mr. A',
//   age = age ?? 30;

//   late String name;
//   late int age;
// }

class Person {
  String name;
  int age;

  Person.other({String? name, int? age})
    : name = name ?? 'Mr.A',
      age = age ?? 30;
}
