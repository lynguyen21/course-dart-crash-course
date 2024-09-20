void main(List<String> args) {
  const thisList = [1, 2, 3];
  final thatList = thisList;
  print(thisList);
  print(thatList);
  const someList = thisList;
  print(someList);
  // const someList = thatList; is invalid
}