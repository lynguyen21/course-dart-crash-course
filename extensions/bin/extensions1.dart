// Extensions in Dart allow you to add new functionality to existing classes or types without modifying their original source code.
// They provide a way to extend the behavior of a class from outside its original definition.

// Extending Strings

// extension on String {
//   String get reversed => split('').reversed.join();
// }

// void main() {
//   String original = "Hello, world!";
//   String reversedString = original.reversed;

//   print("Original: $original");
//   print("Reversed: $reversedString");
// }

// Sum of Iterable

void main(List<String> args) {
  print([1, 2, 3].sum);
  print([2.2, 3.3, 4.4].sum);
  print('range on int');
  print(1.to(10));
  // Output: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  print(1.to(10, inclusive: false));
  // Output: [1, 2, 3, 4, 5, 6, 7, 8, 9]
  print(10.to(1));
  // Output: [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
  print(10.to(1, inclusive: false));
  // Output: [10, 9, 8, 7, 6, 5, 4, 3, 2]
  print(10.to(10));
  // Output: [10]
  print(10.to(10, inclusive: false));
  // Output: []

  print('Finding Duplicated Values in Iterable');
  print([1, 2, 3].containsDuplicateValues);
  // Output: false

  print([1, 2, 3, 1].containsDuplicateValues);
  // Output: true

  print(['Foo', 'Bar'].containsDuplicateValues);
  // Output: false

  print(['Foo', 'Bar', 'foo'].containsDuplicateValues);
  // Output: false

  print(['Foo', 'Bar', 'Foo'].containsDuplicateValues);
  // Output: true
}

// utilize T (generics) to get data type
extension SumOfIterable<T extends num> on Iterable<T> {
  T get sum =>
      reduce((a, b) => a + b as T); // reduce requires the list to be non-empty.
}
// First step: a = 1, b = 2 → result is 3
// Second step: a = 3, b = 3 → result is 6

//
// ***
//

// Range on int
// Dart doesn't support range like in Python or other modern language. We have to implement it ourselves.

extension on int {
  Iterable<int> to(int end, {bool inclusive = true}) =>
      end > this
          ? [for (var i = this; i < end; i++) i, if (inclusive) end]
          : [for (var i = this; i > end; i--) i, if (inclusive) end];
}

// Finding Duplicated Values in Iterable
// Converts the iterable to a Set
// A Set automatically removes duplicate values, because it only stores unique elements.

extension on Iterable {
  bool get containsDuplicateValues => toSet().length != length;
}
