# Macros in Dart

## Ideas:

In Dart, macros are a form of compile-time metaprogramming that allow you to inspect, generate, and modify code during the compilation process. 
They enable developers to reduce boilerplate, enforce constraints, and automate repetitive tasks by defining reusable logic that interacts with the program's structure.

## Key Features of Macros in Dart:

1. **Compile-Time Execution**: Macros operate during the compilation phase, not at runtime.
2. **Boilerplate Reduction**: Simplify the implementation of repetitive patterns like toString, copyWith, and serialization methods.
3. **Code Inspection**: They can analyze classes, methods, fields, or other program elements.
4. **Code Generation**: Macros can generate new code, such as methods or constructors, based on the inspected elements.
5. **Validation**: They can validate annotations, types, or other properties of program elements and throw compile-time errors for invalid structures.

## Use Cases:

- **Serialization**: Auto-generate `toJson` and `fromJson` methods.
- **Validation**: Check that annotated elements adhere to specific rules (e.g., type constraints).
- **Code Transformation**: Add methods, fields, or other constructs dynamically.
- **Boilerplate Reduction**: Simplify code by automating repetitive tasks

## Examples:

- **No Manual Updates**: When new fields are added to the User class, the macro automatically updates the `toString` and `copyWith` methods.
- **Cleaner Code**: Developers write only the core structure of the class and rely on the macro for repetitive tasks.
- **Error Reduction**: Eliminates the risk of human errors in boilerplate code.
- **Compiled-time behavior**:  When the code is compiled, the macro is executed. It inspects the class structure and injects the generated code into the compiled output.

## Notes:

Run macro codes: dart run --enable-experiment=macros bin/transaction_tracker_ver4.dart

**Step 1: Define the Macro**

```
import 'dart:macro';

class AutoGenerateMacro implements Macro {
  const AutoGenerateMacro();

  @override
  void buildDeclarationsForType(
      Declaration declaration, MacroBuilder builder) {
    if (declaration is ClassDeclaration) {
      final fields = declaration.fields.map((field) => field.name).toList();

      // Generate a `toString` method
      final toStringMethod = """
      @override
      String toString() {
        return '${declaration.name}(${fields.map((f) => "\$${f}").join(", ")})';
      }
      """;

      // Generate a `copyWith` method
      final copyWithMethod = """
      ${declaration.name} copyWith({
        ${fields.map((f) => '${field.type} $f,').join('\n')}
      }) {
        return ${declaration.name}(
          ${fields.map((f) => '$f: $f ?? this.$f,').join('\n')}
        );
      }
      """;

      // Add the generated methods to the class
      builder.addDeclaration(toStringMethod);
      builder.addDeclaration(copyWithMethod);
    }
  }
}
```

**Step 2: Apply the Macro to a Class**
The macro `AutoGenerateMacro()` inspects the class and generates the necessary boilerplate methods like toString and copyWith.

```

@AutoGenerateMacro()
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});
}
```

**Step 3: Resulting Generated Code**

The macro will automatically generate the following methods during compilation:

```
@AutoGenerateMacro()
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});

  @override
  String toString() {
    return 'User(name: $name, age: $age)';
  }

  User copyWith({
    String? name,
    int? age,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}
```
