// Adding two Optional Integers
// Create helper methods or extensions to perform custom operation to add 2 optional integers
// Create shadow variable to compare value to null

void main(List<String> args) {
  print(
    add(),
  ); // Print 0 (both parameters are null, so the custom '+' operator returns 0)
  print(
    add(10, null),
  ); // Print 10 (one parameter is null, so the custom '+' operator returns the non-null value)
  print(
    add(null, 20),
  ); // Print 20 (one parameter is null, so the custom '+' operator returns the non-null value)
  print(
    add(10, 20),
  ); // Print 30 (both parameters are non-null, so regular addition is performed)
}

/// The 'add' function performs addition of two optional integer parameters.
/// If any of the parameters is null, the custom '+' operator defined in the 'NullableAdd' extension is used.
/// The result of the addition is returned.
int add([int? a, int? b]) {
  return a + b;
}

/// The 'NullableAdd' extension adds a custom '+' operator to nullable numeric types.
/// It performs addition between two nullable values, handling cases where either or both values are null.
extension NullableAdd<T extends num> on T? {
  T operator +(T? other) {
    final thisShadow = this;
    // if this != null && other == null, return this
    if (this != null && other == null) {
      return this as T;
    }
    // if this == null && other != null, return other
    else if (this == null && other != null) {
      return other;
    }
    // if this != null && other != null, return this + other
    else if (thisShadow != null && other != null) {
      return thisShadow + other as T;
    }
    // if this == null && other == null, return 0
    else {
      return 0 as T;
    }
  }
}
