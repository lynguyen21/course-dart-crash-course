extension MapOperations<K, V> on Map<K, V> {
  // Add
  // Map<K, V> operator +(Map<K, V> other) => {...this, ...other};
  Map<K, V> operator +(Map<K, V> other) {
    return {...this, ...other};
    // ...this and ...other are spread operators, which copy all key-value pairs from one map into another.

    /// ... is destructuring: meaning: this: { a: 1}, other: { b: 2 } -> {a:1, b:2}
    // if we write { this, other } -> {{a:1}, {b:2}}
    // destructuring means to pick up all pairs of key and value inside the map
  }

  // Subtract
  Map<K, V> operator -(Map<K, V> other) {
    // {...this} ~ this : { a : 1}
    return {...this}..removeWhere((key, value) {
      return other.containsKey(key) && other[key] == value;
    });
    // obj.foo().foo() -> obj.foo() = 5; .foo() 5.foo() meaningless
    // obj..foo()..foo(); after the first time foo() is called, the function returns the same old object so you can call foo() second time
  }

  // Multiply
  Iterable<Map<K, V>> operator *(int times) sync* {
    for (var i = 0; i < times; i++) {
      yield this;
    }
  }
}

void main() {
  // Example maps
  Map<String, int> map1 = {'a': 1, 'b': 2};
  Map<String, int> map2 = {'b': 2, 'c': 3};

  // + operator (merge)
  var merged = map1 + map2;
  print('Merged (+): $merged'); // {'a': 1, 'b': 2, 'c': 3}

  // - operator (subtract matching key-value pairs)
  var subtracted = map1 - map2;
  print('Subtracted (-): $subtracted'); // {'a': 1}

  // * operator (repeat the map n times as Iterable of maps)
  var repeated = map1 * 3;
  print('Repeated (*):');
  for (var m in repeated) {
    print(m); // prints map1 three times
  }
}
