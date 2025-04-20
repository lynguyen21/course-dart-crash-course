mixin Hashable {
  @override
  int get hashCode {
    // Calculate the hash code based on the object's properties
    int hash = 17;
    hash = 31 * hash + property1.hashCode;
    hash = 31 * hash + property2.hashCode;
    return hash;
  }
}

/// A class representing an example object.
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
