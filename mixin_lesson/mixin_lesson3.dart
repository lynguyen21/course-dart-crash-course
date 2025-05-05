import 'dart:math';
import 'dart:mirrors';
/**
 * Mixin allows you to reuse feature of another class without inheritance. It helps a class to reuse features from multiples entities
 * It is used to solve the issue of single inheritance
 * 
 */

/// The [Hashable] mixin allows classes to inherit the [hashCode] implementation,
/// which calculates the hash code based on the object's properties. It is useful
/// for data structures like `Set` and `Map` that rely on hash codes for efficient
/// lookups and equality comparisons.

mixin Hashable {
  // we need to define the type of property1 and property2 so any class extending this mixin can reuse the property1 and property2
  int? property1; // we need to define a
  String? property2;

  @override
  int get hashCode {
    // Calculate the hash code based on the object's properties
    // in this example, the object has property1 and property2
    // we calculate the total hashcode of it based on property1 and property2 hashcode
    // every object has a default hashcode value based on its default hashcode implementation
    int temp0 = 17;
    print('propety1 hashcode: ${property1.hashCode}');
    print('propety2 hashcode: ${property2.hashCode}');
    int temp1 = 31 * temp0 + property1.hashCode;
    int hash = 3 * temp1 + property2.hashCode;

    return hash;
  }
}

/// A class representing an example object.
/// hashCode is a special property used to support efficient lookup and comparison of objects,
/// especially in hash-based collections like Set and Map.
/// hashCode is an integer representation of an object
/// it must be equivalent with ==; if A == B is true, then A.hashCode == B.hashCode is also true
/// When we look up an object in Set or Map, we can compute its hash and see if the hash exists in the set or map
/// if we do not
class HashableStudent with Hashable {
  final int property1;
  final String property2;

  HashableStudent(this.property1, this.property2);

  // Override == to compare object content instead of identity
  @override
  bool operator ==(Object other) =>
      other is HashableStudent &&
      property1 == other.property1 &&
      property2 == other.property2;
}

/// Mixin for toString
///
/// Reflect function will give you an object of type InstanceMirror.
/// Using this InstanceMirror you can get the name and type declarations of the type which you're reflecting upon
mixin HasDescription {
  @override
  String toString() {
    // toString() method to get a string representation of the object.
    final reflection = reflect(this);
    // Uses the reflect() function from dart:mirrors to create a InstanceMirror of the current object (this).
    final thisType = MirrorSystem.getName(reflection.type.simpleName);
    // Converts that symbol into a human-readable string

    final variables =
        reflection.type.declarations.values.whereType<VariableMirror>();
    // whereType: Filters the list and keeps only variables

    final properties =
        <String, dynamic>{
          for (final field in variables)
            field.asKey:
                reflection
                    .getField(field.simpleName)
                    .reflectee, // reflectee: gets the actual value
        }.toString();

    return '$thisType = $properties';
  }
}

/// The 'AsKey' extension adds a 'asKey' getter to the 'VariableMirror' class.
/// It retrieves the field name and type using reflection and formats them as a string.
extension AsKey on VariableMirror {
  String get asKey {
    final fieldName = MirrorSystem.getName(simpleName);
    final fieldType = MirrorSystem.getName(type.simpleName);
    return '$fieldName ($fieldType)';
  }
}

/// The 'Person' class represents a person and includes the 'HasDescription' mixin.
/// It has 'name' and 'age' fields, and a constructor to set their values.
class HasDesriptionPerson with HasDescription {
  final String name;
  final int age;

  const HasDesriptionPerson({required this.name, required this.age});
}

class HasDescriptionHouse with HasDescription {
  final String address;
  final int rooms;

  const HasDescriptionHouse({required this.address, required this.rooms});
}

class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});
}

class House {
  final String address;
  final int rooms;

  const House({required this.address, required this.rooms});
}

void main() {
  print('mixin used in hashCode');
  final obj1 = HashableStudent(10, 'Hello');
  final obj2 = HashableStudent(10, 'Hello');

  print(obj1.hashCode); // Same hash code
  print(obj2.hashCode); // Same hash code
  print(obj1 == obj2); // true

  final set = <HashableStudent>{};
  set.add(obj1);
  set.add(obj2);

  print(set.length); // Output: 1 (corrected!)

  print('===\n');
  print('mixin used in toString()');

  final personHasDescription = HasDesriptionPerson(name: 'John', age: 30);
  print(personHasDescription);
  // print Person = {name (String): John, age (int): 30}

  final person = Person(name: 'John', age: 30);
  print(person);
  // print Person = {name (String): John, age (int): 30}

  final houseHasDescription = HasDescriptionHouse(
    address: '123 Main St',
    rooms: 6,
  );
  print(houseHasDescription);

  final house = House(address: '123 Main St', rooms: 6);
  print(house);
}
