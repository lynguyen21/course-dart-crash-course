late String name;
// 'late' the variable is not immediately initialized but will be assigned a value later before being used.
void main(List<String> args) {
  try {
    print(name);
  } catch (e) {
    print(e);
  }
  name = 'Food Bar';
  print(name);
  name = 'Food Bar 2';
  print(name);
}
