class Transaction {
  // Fields (properties)
  DateTime date;
  double amount;
  String from;
  String to;
  String description;

  // Constructor with named parameters and default values
  Transaction({
    DateTime? date,
    this.amount = 0,
    this.from = 'None',
    this.to = 'None',
    this.description = 'None',
  }) : date = date ?? DateTime.now();
}

class Account {
  String name;
  int accountNumber;
  double amount;
  List<Transaction> income;
  List<Transaction> expense;

  Account({
    this.name = 'None',
    this.accountNumber = 0,
    this.amount = 0,
    this.income = const [],
    this.expense = const [],
  });

  void addIncome(Transaction transaction) {
    income.add(transaction);
  }

  void addExpense(Transaction transaction) {
    expense.add(transaction);
  }

  double showBalance() {
    double balance = 0;
    for (var transaction in income) {
      print(transaction.amount);
      balance += transaction.amount;
    }
    for (var transaction in expense) {
      balance -= transaction.amount;
    }

    return balance;
  }
}

class Human {
  String name;
  int age;

  Human({this.name = 'None', this.age = 0});

  void say(String content) {
    print(content);
  }
}

void main() {
  var transaction1 = Transaction();
  // print(transaction1.amount);
  // print(transaction1.from);
  // print(transaction1.to);
  // print(transaction1.description);

  Transaction transaction2 = Transaction(
      amount: 2, from: "Quoc", to: "Ly", description: "chuyen tien");
  // print(transaction2.amount);
  // print(transaction2.from);
  // print(transaction2.to);
  // print(transaction2.description);

  Account account1 = Account(
      name: "Giang",
      accountNumber: 1234567,
      amount: 2.000,
      income: [],
      expense: []);

  Transaction transaction3 =
      Transaction(amount: 4.0, from: "A", to: "B", description: "donation");

  account1.addExpense(transaction3);

  // method:
  // account1.foo();
  account1.addIncome(transaction2);

  print(account1.showBalance());

  //print(account1.income[0].amount);
  // print(account1.name);
  // print(account1.accountNumber);
  // print(account1.amount);
  // print(account1.income);
  // print(account1.expense);

  // create an instance of the class Human
  // var ly = Human(name: "Ly", age: 30);
  // var quoc = ...
}
