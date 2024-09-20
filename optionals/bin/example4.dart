void main(List<String> args) {
  String? lastName;
  lastName ??= 'Bar';
  // ??= operator checks if lastName is null
  // assigns the value 'Bar' to lastName only if lastName is currently null
  print(lastName);
}
