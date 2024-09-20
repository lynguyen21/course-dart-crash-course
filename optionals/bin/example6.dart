// void main(List<String> args) {
//   List<String?>? names = [];
//   // The variable names is not null because it is explicitly initialized as an empty list with names = []
//   names.add('Food');
//   //names?.add('Food');
//   //If names is not null, 'Food' will be added to the list.
//   //If names is null, 'Food' will not be added, and no error will occur if you use ?.
//   print(names);
// }

void main(List<String> args) {
  List<String?>? names;
  names?.add('Food');
  names?.add(null);
  print(names);

  final String? first = names?.first;
  // If names is not null, it tries to access .first.
  // If names is null, it does not attempt to access .first and simply returns null.
  print(first ?? 'No first name found');
  // The ?? operator checks if first is null.
  // Since first was assigned null (because names was null), the fallback string 'No first name found' is printed instead.
  names = [];
  names.add('Baz');
  names.add(null);
  print(names);
}
