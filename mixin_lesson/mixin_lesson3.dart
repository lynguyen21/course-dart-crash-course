/**
 * Mixin allows you to reuse feature of another class without inheritance. It helps a class to reuse features from multiples entities
 * It is used to solve the issue of single inheritance
 * 
 */

mixin Hashable {
  // we need to define the type of property1 and property2 so any class extending this mixin can reuse the property1 and property2
  int? property1; // we need to define a
  String? property2;

  @override
  int get hashCode {
    // Calculate the hash code based on the object's properties
    // in this example, the object has property1 and property2
    // we calculate the total hashcode of it based on property1 and property2 hashcode
    int hash = 17;
    hash = 31 * hash + property1.hashCode;
    hash = 31 * hash + property2.hashCode;
    return hash;
  }
}

/// A class representing an example object.
/// hashCode is a special property used to support efficient lookup and comparison of objects,
/// especially in hash-based collections like Set and Map.
/// hashCode is an integer representation of an object
/// it must be equivalent with ==; if A == B is true, then A.hashCode == B.hashCode is also true
/// When we look up an object in Set or Map, we can compute its hash and see if the hash exists in the set or map
class MyClass with Hashable {
  final int property1;
  final String property2;

  MyClass(this.property1, this.property2);

  // Override == to compare object content instead of identity
  @override
  bool operator ==(Object other) =>
      other is MyClass &&
      property1 == other.property1 &&
      property2 == other.property2;
}

void main() {
  final obj1 = MyClass(10, 'Hello');
  final obj2 = MyClass(10, 'Hello');

  print(obj1.hashCode); // Same hash code
  print(obj2.hashCode); // Same hash code
  print(obj1 == obj2); // true

  final set = <MyClass>{};
  set.add(obj1);
  set.add(obj2);

  print(set.length); // Output: 1 (corrected!)
}
