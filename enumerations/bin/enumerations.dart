// Create many objects with the same structure quickly
// Enums are predefined objects, thus new variables can only be in the set of predefined constants
// Examples: Animal type objects (Dogs,Cats,...) can be defined at the same time

// Types of Enum

// Single enum:

// Simple Enum initialization
// enum AnimalType { cat, dog, fish }

// // Define the class Animal with type defined above
// class Animal {
//   final String name;
//   final AnimalType type;
//   const Animal({required this.name, required this.type});
// }

// void main() {
//   // Create an instance of Animal
//   final woof = Animal(name: 'Woof', type: AnimalType.cat);

//   // Print the properties of the animal
//   print('Animal Name: ${woof.name}');
//   print('Animal Type: ${woof.type}');
// }

// Enhanced Enum
// enum Car {
//   tesla1(model: 'Tesla', year: 2021),
//   tesla2(model: 'Tesla', year: 2022);

//   final String model;
//   final int year;
//   const Car({required this.model, required this.year});
// }

// void main() {
//   // Iterate over all Car values and print their details
//   for (var car in Car.values) {
//     print('Car: ${car.name}, Model: ${car.model}, Year: ${car.year}');
//   }
// }

// Converting string input to enum with switch
// Define the AnimalType enum
enum AnimalType { cat, dog, bird, lizard, fish }

// Function to convert a string input to an AnimalType
// AnimalType? animalType({required String input}) {
//   switch (input) {
//     case 'cat':
//       return AnimalType.cat;
//     case 'dog':
//       return AnimalType.dog;
//     case 'bird':
//       return AnimalType.bird;
//     case 'lizard':
//       return AnimalType.lizard;
//     case 'fish':
//       return AnimalType.fish;
//     default:
//       return null; // Return null if the input doesn't match any case
//   }
// }

// void main() {
//   // Example usage
//   const input = 'dog';
//   final result = animalType(input: input);

//   if (result != null) {
//     print('Animal Type: $result');
//   } else {
//     print('Invalid input: $input');
//   }
// }

// Mixins
// Mixin is a way of defining code that can be reused in multiple class hierarchies (will be covered more in lecture 12)
// Mixin can be used with enum to implement common member functions

// Build a mixin
// Define the mixin CanJump
// mixin CanJump {
//   int get height; // Abstract getter for height
//   void jump() {
//     if (height < 2) {
//       throw Exception("Can't Jump");
//     } else {
//       print("Jumped");
//     }
//   }
// }

// // Enum with CanJump mixin
// enum Animal with CanJump {
//   dog(height: 3),
//   cat(height: 1);

//   @override
//   final int height; // Implements the abstract getter from CanJump

//   const Animal({required this.height});
// }

// void main(List<String> args) {
//   try {
//     Animal.dog.jump(); // Will print "Jumped"
//   } catch (e) {
//     print(e);
//   }

//   try {
//     Animal.cat.jump(); // Will throw an exception
//   } catch (e) {
//     print(e); // Prints "Exception: Can't Jump"
//   }
// }

// Extensions
// Extensions is useful to allow further functionality of enums
// enum Animal { cat, dog, bird, lizard, fish }

// extension Jump on Animal {
//   void jump() {
//     print('$this is jumping');
//   }
// }

// void main(List<String> args) {
//   Animal.dog.jump();
// }

// Comparisions
// Enums can also implement Comparision, allowing two predefined types to be comparable

// enum Tesla implements Comparable<Tesla> {
//   tesla1(year: 2021),
//   tesla2(year: 2022),
//   tesla3(year: 2023);

//   final int year;
//   const Tesla({required this.year});

//   @override
//   int compareTo(Tesla other) {
//     return year.compareTo(other.year);
//   }
// }

// void main(List<String> args) {
//   print([...Tesla.values]..sort());
//   // Will print out tesla1, tesla2, tesla3 since 2021 < 2022 < 2023
// }

// Pattern Matching
// Pattern Matching can be compatible with enums

enum AccessType { admin, user, denied }

AccessType getAccessType(bool hasAccess, bool isOwner) {
  if (hasAccess && isOwner) {
    return AccessType.admin;
  } else if (hasAccess && !isOwner) {
    return AccessType.user;
  } else {
    return AccessType.denied;
  }
}

void main() {
  bool hasAccess = true;
  bool isOwner = false;

  AccessType access = getAccessType(hasAccess, isOwner);
  print(access); // Output: AccessType.user
}
