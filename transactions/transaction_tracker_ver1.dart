import 'dart:io';

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

// test comment
class Account {
  String name;
  int accountNumber;
  double balance;
  List<Transaction> income;
  List<Transaction> expense;

  Account({
    this.name = 'None',
    this.accountNumber = 0,
    this.balance = 0,
    this.income = const [],
    this.expense = const [],
  });

  /**
   * When earn money
   */
  void addIncome(Transaction transaction) {
    income.add(transaction);
    balance += transaction.amount;
  }

  /**
   * when spend money
   */
  void addExpense(Transaction transaction) {
    if (balance >= transaction.amount) {
      balance -= transaction.amount;
      expense.add(transaction);
    } else {
      print('Balance is not enough!');
      //throw Exception('Not enought money'); // program will stop here
    }
  }

  double getBalance() {
    // print(balance); no need to print here
    return balance;
  }
}

void printMenu() {
  print('Press 1 to enter income');
  print('Press 2 to enter expense');
  print('Press 3 to enter show balance');
  print('Press 4 to enter exit');
}

void main() {
  // Transaction transaction0 = Transaction();

  // Transaction transaction1 = Transaction(
  //     amount: 2, from: "Quoc", to: "Ly", description: "chuyen tien");
  // print(transaction2.amount);
  // print(transaction2.from);
  // print(transaction2.to);
  // print(transaction2.description);

  Account account1 = Account(
      name: "Giang",
      accountNumber: 1234567,
      balance: 2.000,
      income: [],
      expense: []);

  // Transaction transaction2 =
  //     Transaction(amount: 4.0, from: "A", to: "B", description: "donation");

  // //account1.addIncome(transaction1);

  // account1.addExpense(transaction2);

  // print(account1.getBalance());
  // how to get user input in dart
  while (true) {
    printMenu();
    print("Enter your option");
    String? option = stdin.readLineSync();
    if (option == "3") {
      print(account1.balance);
    } else if (option == "1") {
      //stdout.write("Enter income amount: ");
      print("Enter income amount: ");
      double incomeAmount = double.parse(stdin.readLineSync()!);
      print("Enter sender: ");
      String from = stdin.readLineSync()!;
      print("Enter description: ");
      String description = stdin.readLineSync()!;
      Transaction income = Transaction(
          amount: incomeAmount, from: from, description: description);
      account1.addIncome(income);
      print("Income added successfully!");
    } else if (option == "2") {
      print("Enter expense amount: ");
      double expenseAmount = double.parse(stdin.readLineSync()!);
      print("Enter receiver: ");
      String to = stdin.readLineSync()!;
      print("Enter description: ");
      String description = stdin.readLineSync()!;
      Transaction expense =
          Transaction(amount: expenseAmount, to: to, description: description);
      account1.addExpense(expense);
      // print("Expense added successfully!");
    } else if (option == "4") {
      break;
    } else {
      print("Invalid option");
      break;
    }
  }
}
