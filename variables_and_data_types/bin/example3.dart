void main(List<String> args) {
  var address = '123 Main St';
  print(address);
  address = '245 Main St';
  print(address);
  address  = address.replaceAll('Main', 'Bla');
  print(address);
}