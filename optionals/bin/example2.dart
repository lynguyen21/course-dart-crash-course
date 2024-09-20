void main(List<String> args) {
  const double? someValue =
      null; //someValue can be either a double or null (nullable type)
  print(someValue);
  int? age = 20; // age either holds an int value or null.
  age = null;
  print(age);
  //age = 20: Initially, age is set to 20.
  //age = null: Then, age is reassigned to null.
}
