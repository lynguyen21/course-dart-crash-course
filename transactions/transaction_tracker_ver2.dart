import 'dart:io';

class Transaction {
  DateTime date;
  double amount;
  String from;
  String to;
  String description;
  String category; // New field for categorization

  Transaction({
    DateTime? date,
    this.amount = 0,
    this.from = 'None',
    this.to = 'None',
    this.description = 'None',
    this.category = 'Uncategorized', // Default category
  }) : date = date ?? DateTime.now();
}

class Account {
  String name;
  int accountNumber;
  double balance;
  List<Transaction> income;
  List<Transaction> expense;
  double expenseLimit; // New field for expense limits
  List<Transaction> recurringTransactions; // New field for recurring transactions

  Account({
    this.name = 'None',
    this.accountNumber = 0,
    this.balance = 0,
    this.income = const [],
    this.expense = const [],
    this.expenseLimit = double.infinity, // No limit by default
    this.recurringTransactions = const [],
  });

  void addIncome(Transaction transaction) {
    income.add(transaction);
    balance += transaction.amount;
  }

  void addExpense(Transaction transaction) {
    if (balance >= transaction.amount) {
      if ((getTotalExpenses() + transaction.amount) > expenseLimit) {
        throw Exception('Expense limit exceeded! Current limit: $expenseLimit');
      }
      balance -= transaction.amount;
      expense.add(transaction);
    } else {
      throw Exception('Not enough money!');
    }
  }

  double getTotalExpenses() {
    return expense.fold(0, (sum, t) => sum + t.amount);
  }

  void addRecurringTransaction(Transaction transaction) {
    recurringTransactions.add(transaction);
  }

  void processRecurringTransactions() {
    for (var transaction in recurringTransactions) {
      addExpense(transaction);
    }
  }

  double getBalance() {
    return balance;
  }
}

void printMenu() {
  print('Press 1 to enter income');
  print('Press 2 to enter expense');
  print('Press 3 to show balance');
  print('Press 4 to set expense limit');
  print('Press 5 to add recurring transaction');
  print('Press 6 to process recurring transactions');
  print('Press 7 to exit');
}

void main() {
  Account account1 = Account(
      name: "Giang",
      accountNumber: 1234567,
      balance: 2000.00,
      income: [],
      expense: [],
      expenseLimit: 500.00, // Setting a default limit
      recurringTransactions: []);

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
        print("Enter category: ");
        String category = stdin.readLineSync()!;

        Transaction incomeTransaction = Transaction(
            amount: incomeAmount, from: from, description: description, category: category);
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
        print("Enter category: ");
        String category = stdin.readLineSync()!;

        Transaction expenseTransaction = Transaction(
            amount: expenseAmount, to: to, description: description, category: category);
        try {
          account1.addExpense(expenseTransaction);
          print("Expense added successfully!");
        } catch (e) {
          print(e);
        }
        break;

      case "3":
        // Show balance
        print("Current balance: ${account1.getBalance()}");
        break;

      case "4":
        // Set expense limit
        print("Enter new expense limit: ");
        double newLimit = double.parse(stdin.readLineSync()!);
        account1.expenseLimit = newLimit;
        print("Expense limit set to: $newLimit");
        break;

      case "5":
        // Add recurring transaction
        print("Enter recurring transaction amount: ");
        double recurringAmount = double.parse(stdin.readLineSync()!);
        print("Enter category for recurring transaction: ");
        String recurringCategory = stdin.readLineSync()!;
        Transaction recurringTransaction = Transaction(
            amount: recurringAmount,
            description: 'Recurring Expense',
            category: recurringCategory);
        account1.addRecurringTransaction(recurringTransaction);
        print("Recurring transaction added successfully!");
        break;

      case "6":
        // Process recurring transactions
        account1.processRecurringTransactions();
        print("Recurring transactions processed.");
        break;

      case "7":
        // Exit the loop
        print("Exiting the program.");
        return;

      default:
        print("Invalid option, please try again.");
    }
  }
}
