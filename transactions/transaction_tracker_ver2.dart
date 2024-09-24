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
   * Add income and update balance
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
      //print('Balance is not enough!');
      throw Exception(
          'Not enough money!'); // program will stop here with exception
    }
  }

  // Get current account balance
  double getBalance() {
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
  Account account1 = Account(
      name: "Giang",
      accountNumber: 1234567,
      balance: 2.000,
      income: [],
      expense: []);

  while (true) {
    printMenu();
    print("Enter your option:");
    String? option = stdin.readLineSync();

    switch (option) {
      case "1":
        // Add income
        print("Enter income amount: ");
        double incomeAmount = double.parse(stdin.readLineSync()!);
        print("Enter sender: ");
        String from = stdin.readLineSync()!;
        print("Enter description: ");
        String description = stdin.readLineSync()!;

        Transaction incomeTransaction = Transaction(
            amount: incomeAmount, from: from, description: description);
        account1.addIncome(incomeTransaction);
        print("Income added successfully!");
        break;

      case "2":
        // Add expense
        print("Enter expense amount: ");
        double expenseAmount = double.parse(stdin.readLineSync()!);
        print("Enter receiver: ");
        String to = stdin.readLineSync()!;
        print("Enter description: ");
        String description = stdin.readLineSync()!;

        Transaction expenseTransaction = Transaction(
            amount: expenseAmount, to: to, description: description);
        // "try-catch": the program can "catch" the error, print a message ("Not enough money!"), and continue running, instead of crashing.
        try {
          account1.addExpense(expenseTransaction);
          print("Expense added successfully!");
        } catch (e) {
          print(
              e); // Handle insufficient balance error and print a message ("Not enough money!")
        }
        break;

      case "3":
        // Show balance
        print("Current balance: ${account1.getBalance()}");
        break;

      case "4":
        // Exit the loop
        print("Exiting the program.");
        return;

      default:
        // Invalid option
        print("Invalid option, please try again.");
    }
  }
}
