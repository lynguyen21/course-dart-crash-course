// void main(List<String> args) {
//   try {
//     final String? firstName = null;
//     print(firstName!);
//   }
//   final String? firstName = null;
//   final food = firstName!;
//   // The ! is the null assertion operator in Dart, which tells the compiler: "I know for sure that firstName is not null."
//   // However, since firstName is actually null, this assertion will fail, causing a runtime error.
//   print(food);
// }

// void main(List<String> args) {
//   try {
//     final String? firstName = null;
//     // A final variable firstName is declared, meaning its value cannot be changed after initialization.
//     // The String? indicates that firstName can hold a null value (nullable type), and it's assigned null.
//     print(firstName!);
//     // The ! operator is called a "null check" operator. It forces the program to treat firstName as non-null.
//     // Since firstName is actually null, using ! will cause a NullPointerException
//   } catch (error) {
//     // The try-catch block catches the exception thrown by the print(firstName!); line.
//     // When the exception occurs, the program jumps to the catch block and prints the error message.
//     print(error);
//   }
// }

void main(List<String> args) {
  try {
    final String? firstName = null;
    print(firstName ?? 'No names found');
  } catch (error) {
    print(error);
  }
}
