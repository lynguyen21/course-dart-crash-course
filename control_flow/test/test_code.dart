// void main() {
//   for (int i = 0; i < 10; i++) {
//     print(11);
//   }
// }

// void main() {
//   int number = 0;
//   while (number < 10) {
//     print(number);
//     number++;
//   }
//   //This code will print the int number and also increment it until it equal to 10. The output will be 0123456789.
// }

// void main() {
//   int number = 0;
//   while (number < 10) {
//     print(number);
//     number++;
//   }
// }

// void main() {
//   do {
//     print('Hello world');
//   } while (false);
//   //Regardless of the condition is false, Hello world will be print one time.
// }

// void main() {
//   int i = 0; // Initialize the counter

//   do {
//     print(i); // Print the current value of i
//     i++; // Increment the counter
//   } while (i <= 10); // Continue the loop while i is less than or equal to 10
// }

// void main() {
//   for (int i = 0; i <= 10; i++) {
//     print(i);
//   }
// }

// void main() {
//   int i = 0;
//   while (i <= 10) {
//     print(i);
//     i++;
//   }
// }

// void main() {
//   int input = 100;
//   switch (input) {
//     case <= 25:
//       print('The input is less than 25');
//       break;
//     case <= 50:
//       print('The input is less than 50');
//       break;
//     case <= 75:
//       print('The input is less than 75');
//       break;
//     default:
//       print('The input is more than 75');
//   }
//   //Each case end with break statement to make sure other cases do not happen.
// }
// void main() {
//   // Declare and initialize the list
//   List<String> sL = ['Open', 'Knect', 'Dart', 'Flutter', 'Knect'];

//   // Print each element of the list
//   for (final s in sL) {
//     print(s);
//   }

//   // Modify each element of the list
//   for (var i = 0; i < sL.length; i++) {
//     sL[i] = 'new string';
//   }

//   // Print the updated list
//   print(sL);

// void main() {
//   List<String> s = ['Dtu', 'Data', 'Dvb', 'Day', 'Date'];

//   // Filter the list to include only elements starting with 'Da'
//   var filteredList = s.where((i) => i.startsWith('Da'));

//   // Print the filtered list
//   print(filteredList);
// }

// void main() {
//   final m = {
//     'myString': 'OpenKnect',
//     'myInt': 2023,
//     'myList': ['Dart', 'Flutter', 'GCP'],
//     'mySet': {1, 2, 3},
//     'myMap': {'a': 0, 'b': 0}
//   };
//   for (final word in m.entries) {
//     print(word.key);
//     print(word.value);
//   }
// }

// void main() {
//   Iterable i = [1, 2, 3, 4];
//   final it = Iterable.generate(10, (i) => [i - 1, i, i + 1]);
//   print(it);
// }

// void main() {
//   final arr = [
//     for (final m in Iterable.generate(4, (i) => i))
//       for (final n in Iterable.generate(4, (i) => i))
//         if (m % 2 == 0 && n % 2 == 1) [m, n]
//   ];

//   print(arr); // Output: [[0, 1], [0, 3], [2, 1], [2, 3]]
// }

// void main() {
//   final arr = [
//     for (final m in Iterable.generate(4, (i) => i))
//       for (final n in Iterable.generate(4, (i) => i))
//         if (m % 2 == 0 && n % 2 == 1) [m, n]
//   ];
//   print(arr);
// }

// Define the enum AnimalType
// enum AnimalType { cat, dog, bird, lizard, fish }

// // Define the class Animal with the type defined above
// class Animal {
//   final String name;
//   final AnimalType type;

//   const Animal({required this.name, required this.type});
// }

// void main() {
//   // Create an instance of Animal
//   final woof = Animal(name: 'Woof', type: AnimalType.dog);

//   print('Animal Name: ${woof.name}, Animal Type: ${woof.type}');
// }

// enum AnimalType { cat, dog, bird }

// class Animal {
//   final String name;
//   final AnimalType type;
//   const Animal({required this.name, required this.type});
// }

// void main() {
//   final woof = Animal(name: 'Woof', type: AnimalType.cat);
//   print('Animal Name: ${woof.name}, Animal Type: ${woof.type}');
// }

// Define the enum Car
// enum Car {
//   tesla1(
//     model: 'Tesla',
//     year: 2021,
//   ),
//   tesla2(
//     model: 'Tesla',
//     year: 2022,
//   );

//   final String model;
//   final int year;
//   const Car({
//     required this.model,
//     required this.year,
//   });
// }

// void main() {
//   // Accessing enum values and their properties
//   for (var car in Car.values) {
//     print('Model: ${car.model}, Year: ${car.year}');
//   }

//   // Example of using a specific enum value
//   final selectedCar = Car.tesla2;
//   print(
//       'Selected Car - Model: ${selectedCar.model}, Year: ${selectedCar.year}');
// }

import 'dart:io';

enum AnimalType { cat, dog, bird, lizard, fish }

// Function to convert string input to enum
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
//       return null;
//   }
// }

// void main() {
//   // Example usage of the animalType function
//   const input = 'cat';
//   final type = animalType(input: input);

//   if (type != null) {
//     print('Animal Type: $type');
//   } else {
//     print('Invalid animal type: $input');
//   }
// }

// Build a mixin
// mixin CanJump {
//   int get height;
//   void jump() {
//     if (height < 2) {
//       throw Exception("Can't Jump");
//     } else {
//       print("Jumped");
//     }
//   }
// }

// // Enum
// enum Animal with CanJump {
//   dog(height: 3),
//   cat(height: 1);

//   @override
//   final int height;
//   const Animal({required this.height});
// }

// // Extension Usage - Additional functionality for the Animal enum
// extension JumpExtension on Animal {
//   void extendedJump() {
//     print('$this is performing an extended jump');
//   }
// }

// void main() {
//   try {
//     Animal.dog.jump(); // Uses the mixin's jump method, prints: "Jumped"
//     Animal.cat.jump(); // Uses the mixin's jump method, throws exception
//   } catch (e) {
//     print(e); // Catches and prints: "Exception: Can't Jump"
//   }

//   // Using the extension's jump method
//   Animal.dog
//       .extendedJump(); // Prints: "Animal.dog is performing an extended jump"
//   Animal.cat
//       .extendedJump(); // Prints: "Animal.cat is performing an extended jump"
// }

enum Tesla implements Comparable<Tesla> {
  tesla1(year: 2021),
  tesla2(year: 2022),
  tesla3(year: 2023);

  final int year;
  const Tesla({required this.year});

  @override
  int compareTo(Tesla other) {
    return year.compareTo(other.year);
  }
}

void main() {
  // Create a sorted list of Tesla values
  final sortedTesla = [...Tesla.values]..sort();

  // Print only the names of the sorted enum values
  for (var tesla in sortedTesla) {
    print(tesla.name); // Prints: tesla1, tesla2, tesla3
  }
}

enum Tesla implements Comparable<Tesla> {
  tesla1(year: 2021),
  tesla2(year: 2022),
  tesla3(year: 2023);

  final int year;
  const Tesla({required this.year});

  @override
  int compareTo(Tesla other) {
    return year.compareTo(other.year);
  }
}
