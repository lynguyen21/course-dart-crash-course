// Update get transaction
import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';

enum Category {
  food,
  gas,
  housing,
  tuition,
  market,
  electricity_bill,
  utilities,
  restaurant,
  insurance,
  salary,
  game,
  other,
}

mixin ImportMixin {
  // import transactions from a CSV string and automatically classify them as income or expense based on the amount.
  void importFromCSV(String csvData) {
    final csvTable = const CsvToListConverter().convert(csvData);
    for (var row in csvTable.skip(1)) {
      // Skip header
      final transaction = Transaction(
        date: DateTime.parse(row[0].toString()),
        amount: double.parse(row[1].toString()),
        from: row[2].toString(),
        to: row[3].toString(),
        description: row[4].toString(),
        category: Category.values.firstWhere(
          (e) => e.toString() == 'Category.${row[5]}',
          orElse: () => Category.other,
        ),
      );

      if (transaction.amount > 0) {
        (this as Account).addIncome(transaction);
      } else {
        (this as Account).addExpense(transaction);
      }
    }
  }
}

mixin ExportMixin {
  //  export all transactions in an Account object to a CSV string, with headers and cleaned-up formatting.
  String exportToCSV() {
    final transactions = (this as Account).getAllTransactions();
    final csvData = List<List<dynamic>>.from([
      ['Date', 'Amount', 'From', 'To', 'Description', 'Category'],
    ]);

    for (var transaction in transactions) {
      csvData.add([
        transaction.date.toIso8601String(),
        transaction.amount,
        transaction.from,
        transaction.to,
        transaction.description,
        transaction.category.toString().replaceFirst('Category.', ''),
      ]);
    }

    return const ListToCsvConverter().convert(csvData);
  }
}

class Transaction {
  DateTime date;
  double amount;
  String from;
  String to;
  String description;
  Category category;

  Transaction({
    DateTime? date,
    this.amount = 0.0,
    this.from = 'None',
    this.to = 'None',
    this.description = 'None',
    this.category = Category.other,
  }) : date = date ?? DateTime.now();

  @override
  String toString() {
    return 'Date: ${date.toLocal()} | Amount: $amount | From: $from | To: $to | Description: $description | Category: $category';
  }
}

class Account with ImportMixin, ExportMixin {
  String name;
  int accountNumber;
  double balance;
  List<Transaction> income;
  List<Transaction> expenses;
  List<Transaction> recurringTransactions;

  /**constructor: the name of the method is the same as the name of the class */
  Account({
    this.name = 'Unnamed Account',
    this.accountNumber = 0,
    this.balance = 0.0,
    List<Transaction>? income,
    List<Transaction>? expenses,
    List<Transaction>? recurringTransactions,
  }) : income = income ?? [],
       expenses = expenses ?? [],
       recurringTransactions = recurringTransactions ?? [];

  void addIncome(Transaction transaction) {
    income.add(transaction);
    balance += transaction.amount;
  }

  void addExpense(Transaction transaction) {
    if (balance >= transaction.amount) {
      expenses.add(transaction);
      balance -= transaction.amount;
    } else {
      throw Exception('Insufficient balance!');
    }
  }

  void addRecurringTransaction(Transaction transaction) {
    recurringTransactions.add(transaction);
  }

  void processRecurringTransactions() {
    for (var transaction in recurringTransactions) {
      addExpense(transaction);
    }
  }

  double getBalance() => balance;

  List<Transaction> getAllTransactions() => [...income, ...expenses];

  List<Transaction> filterTransactionsByCategory(Category category) {
    return getAllTransactions()
        .where((transaction) => transaction.category == category)
        .toList();
  }

  Map<Category, double> getCategorySummary() {
    final summary = <Category, double>{};
    for (var transaction in getAllTransactions()) {
      summary[transaction.category] =
          (summary[transaction.category] ?? 0) + transaction.amount;
    }
    return summary;
  }

  List<Transaction> getTransactionsByDate(DateTime date) {
    return getAllTransactions()
        .where(
          (transaction) =>
              transaction.date.year == date.year &&
              transaction.date.month == date.month &&
              transaction.date.day == date.day,
        )
        .toList();
  }

  bool deleteTransactionByDateAndIndex(DateTime date, int index) {
    final transactionsOnDate = getTransactionsByDate(date);
    if (index < 0 || index >= transactionsOnDate.length) return false;
    // index refers to the position of a transaction within the list of transactions that occurred on a specific date.
    final transactionToRemove = transactionsOnDate[index];

    if (income.contains(transactionToRemove)) {
      income.remove(transactionToRemove);
      balance -= transactionToRemove.amount;
    } else if (expenses.contains(transactionToRemove)) {
      expenses.remove(transactionToRemove);
      balance += transactionToRemove.amount;
    }

    return true;
  }

  void printSummary() {
    print('Account Summary for $name:');
    print('Total Income: ${income.fold(0.0, (sum, t) => sum + t.amount)}');
    print('Total Expenses: ${expenses.fold(0.0, (sum, t) => sum + t.amount)}');
    print('Balance: $balance');
  }
}

void printCategory() {
  print('Select category');
  print('1. food');
  print('2. gas');
  print('3. housing');
  print('4. tuition');
  print('5. market');
  print('6. electricity bill');
  print('7. utilities');
  print('8. restaurant');
  print('9. insurance');
  print('10. salary');
  print('11. game');
}

void printMenu() {
  print('1. Enter income');
  print('2. Enter expense');
  print('3. Show balance');
  print('4. Add recurring transaction');
  print('5. Process recurring transactions');
  print('6. View transaction history');
  print('7. Filter transactions by category');
  print('8. Delete a transaction');
  print('9. View account summary');
  print('10. View category summary');
  print('11. Import transactions');
  print('12. Export transactions');
  print('13. Exit');
}

Category mapIntToCategory(int categorynumber) {
  final categoryEnum;
  switch (categorynumber) {
    case 1:
      categoryEnum = Category.food;
      break;
    case 2:
      categoryEnum = Category.gas;
      break;
    case 3:
      categoryEnum = Category.housing;
      break;
    case 4:
      categoryEnum = Category.tuition;
      break;
    case 5:
      categoryEnum = Category.market;
      break;
    case 6:
      categoryEnum = Category.electricity_bill;
      break;
    case 7:
      categoryEnum = Category.utilities;
      break;
    case 8:
      categoryEnum = Category.restaurant;
      break;
    case 9:
      categoryEnum = Category.insurance;
      break;
    case 10:
      categoryEnum = Category.salary;
      break;
    case 11:
      categoryEnum = Category.game;
      break;
    default:
      categoryEnum = Category.other;
  }

  return categoryEnum;
}

void importTransactions(Account account) {
  try {
    stdout.write("Enter CSV file path to load: ");
    final filePath = stdin.readLineSync()!;
    final csvData = File(filePath).readAsStringSync();
    account.importFromCSV(csvData);
    print("Transactions imported from CSV successfully!");
  } catch (e) {
    print("Failed to import transactions: $e");
  }
}

void exportTransactions(Account account) {
  try {
    stdout.write("Enter output file path to save CSV: ");
    final filePath = stdin.readLineSync()!;
    final csvData = account.exportToCSV();
    File(filePath).writeAsStringSync(csvData);
    print("Transactions exported to CSV successfully!");
  } catch (e) {
    print("Failed to export transactions: $e");
  }
}

void main() {
  final account = Account(
    name: "Giang",
    accountNumber: 1234567,
    balance: 2000.00,
  );

  while (true) {
    printMenu();
    stdout.write("Enter your option: ");
    final option = stdin.readLineSync();

    switch (option) {
      case "1":
        stdout.write("Enter income amount: ");
        final incomeAmount = double.parse(stdin.readLineSync()!);
        stdout.write("Enter sender: ");
        final from = stdin.readLineSync()!;
        stdout.write("Enter description: ");
        final description = stdin.readLineSync()!;
        stdout.write("Enter category: ");
        printCategory();
        final category = int.parse(stdin.readLineSync()!);
        Category categoryEnum = mapIntToCategory(category);
        account.addIncome(
          Transaction(
            amount: incomeAmount,
            from: from,
            description: description,
            category: categoryEnum,
          ),
        );

        print("Income added successfully!");
        break;

      case "2":
        stdout.write("Enter expense amount: ");
        final expenseAmount = double.parse(stdin.readLineSync()!);
        stdout.write("Enter receiver: ");
        final to = stdin.readLineSync()!;
        stdout.write("Enter description: ");
        final description = stdin.readLineSync()!;
        stdout.write("Enter category: ");
        printCategory();
        final category = int.parse(stdin.readLineSync()!);
        Category categoryEnum = mapIntToCategory(category);

        try {
          account.addExpense(
            Transaction(
              amount: expenseAmount,
              to: to,
              description: description,
              category: categoryEnum,
            ),
          );

          print("Expense added successfully!");
        } catch (e) {
          print(e);
        }
        break;

      case "3":
        print("Current balance: ${account.getBalance()}");
        break;

      case "4":
        stdout.write("Enter recurring transaction amount: ");
        final recurringAmount = double.parse(stdin.readLineSync()!);
        stdout.write("Enter category for recurring transaction: ");
        final recurringCategory = int.parse(stdin.readLineSync()!);
        Category categoryEnum = mapIntToCategory(recurringCategory);

        account.addRecurringTransaction(
          Transaction(
            amount: recurringAmount,
            description: 'Recurring Expense',
            category: categoryEnum,
          ),
        );

        print("Recurring transaction added successfully!");
        break;

      case "5":
        account.processRecurringTransactions();
        print("Recurring transactions processed.");
        break;

      case "6":
        print("Transaction History:");
        for (var transaction in account.getAllTransactions()) {
          print(transaction);
        }
        break;

      case "7":
        stdout.write("Enter category to filter: ");
        printCategory();
        final category = int.parse(stdin.readLineSync()!);
        Category categoryEnum = mapIntToCategory(category);

        final filteredTransactions = account.filterTransactionsByCategory(
          categoryEnum,
        );

        print("Filtered Transactions:");
        for (var transaction in filteredTransactions) {
          print(transaction);
        }
        break;

      case "8":
        stdout.write("Enter transaction date (yyyy-MM-dd): ");
        final input = stdin.readLineSync()!;
        DateTime date;

        try {
          date = DateTime.parse(input);
        } catch (e) {
          print("Invalid date format!");
          break;
        }

        final transactionsOnDate = account.getTransactionsByDate(date);
        if (transactionsOnDate.isEmpty) {
          print("No transactions found on this date.");
          break;
        }

        print("Transactions on ${date.toLocal()}:");
        for (int i = 0; i < transactionsOnDate.length; i++) {
          print("[$i] ${transactionsOnDate[i]}");
        }

        stdout.write("Enter the index of the transaction to delete: ");
        final indexInput = stdin.readLineSync();

        int index;
        try {
          index = int.parse(indexInput!);
        } catch (e) {
          print("Invalid index!");
          break;
        }

        final success = account.deleteTransactionByDateAndIndex(date, index);
        if (success) {
          print("Transaction deleted successfully!");
        } else {
          print("Failed to delete transaction. Invalid index or date.");
        }
        break;

      case "9":
        account.printSummary();
        break;

      case "10":
        print("Category Summary:");
        final categorySummary = account.getCategorySummary();

        categorySummary.forEach((category, total) {
          print("Category: $category, Total: $total");
        });
        break;

      case "11":
        importTransactions(account);
        break;

      case "12":
        exportTransactions(account);
        break;

      case "13":
        print("Exiting the program.");
        return;

      default:
        print("Invalid option, please try again.");
    }
  }
}
