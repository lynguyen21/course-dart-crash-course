void main(List<String> args) {
  var myAge = 20;
  print(myAge = 30); // myAge now is 30
  print(myAge ~/= 2); //15
  print(myAge *= 2); //30
  print(myAge += 4); //34
  print(myAge &= 2); //2 (bitwise AND with 2)
  print(myAge |= 4); // 6 (bitwise OR with 4)
  print(myAge ^= 10); // 12 (bitwise XOR with 10)
  print(myAge -= 10); // 2 12-10 =2
  print(myAge);
}
