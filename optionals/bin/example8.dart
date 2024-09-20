void main(List<String> args) {
  final String? firstName = null;
  if (firstName == null) {
    print('firstName value is null');
  } else {
    final int length = firstName.length;
    print(length);
  }
}
