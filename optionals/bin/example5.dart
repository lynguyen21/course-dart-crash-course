// void main(List<String> args) {
//   final lastName = 'Food';
//   print(lastName.length);
// }

void main(List<String> args) {
  String? lastName; // = 'Food';
  print(lastName?.length);

  String? nullName;
  // print(nullName ?? 'Food');
  // If it is, it returns the value after ??, which is 'Food' in this case
  print(lastName ?? 'Food');
  print(lastName ?? nullName);
  //print(lastName ?? nullName ?? 'Bar');
  final bla = lastName ?? nullName ?? 'Bar';
}
