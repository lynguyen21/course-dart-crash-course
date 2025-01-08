import 'package:json/json.dart';

// 1. Enable the macro experiment in analysis_options.yaml
// analyzer:
//   enable-experiment:
//     - macros

// 2. Apply the JsonCodable macro to your class

@JsonCodable()
class User {
  final String id;
  final String name;
  final int age;
  final String education;
  final String school;

  User(this.id, this.name, this.age, this.education, this.school);
}

void main() {
  // Given some arbitrary JSON:
  var userJson = {
    'age': 5,
    'name': 'Roger',
    'username': 'roger1337',
    'school': 'CSU',
    'education': 'Master',
    'id': 'abcd',
  };

  // Use the generated members:
  var user = User.fromJson(userJson); // de-serialization

  print(user);
  print(user.toJson()); // serialization
}

// import 'dart:macro';

// class AutoGenerateMacro implements Macro {
//   const AutoGenerateMacro();

//   @override
//   void buildDeclarationsForType(Declaration declaration, MacroBuilder builder) {
//     if (declaration is ClassDeclaration) {
//       final fields = declaration.fields.map((field) => field.name).toList();

//       // Generate a `toString` method
//       final toStringMethod = """
//       @override
//       String toString() {
//         return '${declaration.name}(${fields.map((f) => "\$${f}").join(", ")})';
//       }
//       """;

//       // Generate a `copyWith` method
//       final copyWithMethod = """
//       ${declaration.name} copyWith({
//         ${fields.map((f) => '${field.type} $f,').join('\n')}
//       }) {
//         return ${declaration.name}(
//           ${fields.map((f) => '$f: $f ?? this.$f,').join('\n')}
//         );
//       }
//       """;

//       // Add the generated methods to the class
//       builder.addDeclaration(toStringMethod);
//       builder.addDeclaration(copyWithMethod);
//     }
//   }
// }

// @AutoGenerateMacro()
// class User {
//   final String name;
//   final int age;

//   User({required this.name, required this.age});

//   @override
//   String toString() {
//     return 'User(name: $name, age: $age)';
//   }

//   User copyWith({String? name, int? age}) {
//     return User(name: name ?? this.name, age: age ?? this.age);
//   }
// }
