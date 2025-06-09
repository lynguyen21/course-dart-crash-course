// Subtracting a String from Another String

// The 'Remove' extension adds a custom '-' operator to the 'String' class.
// It allows subtracting one string from another by removing occurrences of the second string from the first string.
// extension Remove on String {
//   String operator -(String other) => replaceAll(other, '');
// }

// // The 'main' function is the entry point of the Dart program.
// // It demonstrates the usage of the custom '-' operator on strings.
// void main(List<String> args) {
//   print('Foo Bar' - 'Foo'); // return 'Foo'
//   print('Bar' - 'Bar'); // return ''
//   print('Foo Bar' - 'Baz'); // return 'Foo'
// }

extension Remove on String {
  String operator -(String other) => replaceAll(other, '');
}

extension Remove<T> on Iterable<T> {
  Iterable<T> operator -(Iterable<T> other) =>
      where((element) => !other.contains(element));
} // Use where() method along with a condition to filter out the elements that exist in the second iterable

void main(List<String> args) {
  String names = 'Foo Bar';
  print(names - 'Bar');

  print([1, 2, 3] - [1, 2]);
  // Output: [3]

  print([1, 2, 3] - [1, 2, 3]);
  // Output: []

  print([1, 2, 3] - [3, 1, 2]);
  // Output: []

  print(['Foo', 'Bar', 'Baz'] - ['Baz', 'Bar']);
  // Output: [Foo]

  print(['Foo', 'Bar', 'Baz'] - ['Baz']);
  // Output: [Foo, Bar]
}

// Custom Operators on Map
// Operators in Dart are predefined and have fixed behaviors.
// However, you can achieve similar functionality by creating helper methods or extensions to perform custom operations on Map objects

void main() {
  final mapA = {'a': 1, 'b': 2, 'c': 3};
  final mapB = {'b': 2, 'd': 4};

  // Addition: Merges mapA and mapB. mapB's entries overwrite mapA's if keys overlap.
  final addedMap = mapA + mapB;
  print('Added Map: $addedMap'); // Output: {a: 1, b: 2, c: 3, d: 4}

  // Subtraction: Removes entries from mapA that are present in mapB with the same key-value pairs.
  final subtractedMap = mapA - mapB;
  print('Subtracted Map: $subtractedMap'); // Output: {a: 1, c: 3}

  // Multiplication: Creates an iterable of mapA repeated 3 times.
  print(mapA * 3);
}
