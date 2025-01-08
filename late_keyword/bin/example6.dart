void main(List<String> args) {
  final person = Person();

  try {
    // avoid doing this in real codes since it's against
    // the recommendations. instead use nullable values.
    print(person.fullName);
  } catch (e) {
    print(e);
  }
  person.firstName = 'Food';
  person.lastName = 'Bar';
  print(person.fullName);
}

class Person {
  late final String firstName;
  late final String lastName;
  late String fullName = '$firstName $lastName';
}
