// Dart uses try, catch, on, and finally blocks to handle exceptions.
// The try block contains code that may throw an exception, and catch handles it.
/* void main(List<String> args) {
  try {
    int result = 10 ~/ 0;
    print(result);
  } on IntegerDivisionByZeroException {
    print("Cannot divide by zero.");
  } catch (e) {
    print("An error occurred: $e");
  } finally {
    print("Execution completed.");
  }
} */

/* try: Runs code that might throw an exception.
on: Catches a specific type of exception (IntegerDivisionByZeroException).
catch: Provides a generic way to catch exceptions.
finally: Executes code after try and catch, regardless of whether an exception was thrown. */

// // Handling a non-Null Pointer
/* void main() {
  String? name = 'Ly';

  try {
    print(name!.length); // Force a NullPointerException by using ! on null
  } catch (e) {
    print("Error: Null value encountered.");
  } finally {
    print("Attempted to access name.");
  }
} */

// Handling a Null Pointer Exception
/* void main() {
  String? name;

  try {
    print(name!.length); // Force a NullPointerException by using ! on null
  } catch (e) {
    print("Error: Null value encountered.");
  } finally {
    print("Attempted to access name.");
  }
} */

// Multiple Catch Blocks
// void main() {
//   try {
//     String result = ("not_a_number"); // Throws FormatException
//     print(result);
//     // List<int> numbers = [1, 2, 3];
//     // print(numbers[0]); // Uncomment to test RangeError
//   } on RangeError {
//     print("Error: Index out of range.");
//   } catch (e) {
//     print("An unknown error occurred: $e");
//   } finally {
//     print("Operation completed.");
//   }
// }
// Handling format exception
/* void main() {
  String invalidNumber = "abc";

  try {
    int number = int.parse(invalidNumber); // Will throw a FormatException
    print("Parsed number: $number");
  } on FormatException {
    print("Error: Invalid number format.");
  } catch (e) {
    print("An error occurred: $e");
  }
}
 */

void checkAge(int age) {
  if (age < 18) {
    throw Exception("Age must be 18 or older.");
  }
  print("Access granted.");
}

void main() {
  try {
    checkAge(16); // This will throw an exception
  } catch (e) {
    print("Caught an exception: $e");
  } finally {
    print("Check completed.");
  }
}

// throw manually raises an Exception inside checkAge(). throw in void ()

// try attempts to run it.

// catch handles the exception.

// finally runs no matter what (cleanup, logging, etc.).
