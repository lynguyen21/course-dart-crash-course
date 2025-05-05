import 'package:uuid/uuid.dart';

mixin HasIdentifier {
  String get id;
}

class Person with HasIdentifier {
  @override
  final String id;
  final String name;
  final int age;

  Person({required this.id, required this.name, required this.age});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

void main(List<String> args) {
  final uuid = Uuid();

  final uuid1 = uuid.v4();
  final uuid2 = uuid.v4();

  final person1 = Person(id: uuid1, name: "John", age: 30);
  final person1again = Person(id: uuid1, name: "John", age: 30);
  final person2 = Person(id: uuid2, name: "John", age: 30);

  print(person1 == person1again); // true
  print(person1 == person2); // false
}
