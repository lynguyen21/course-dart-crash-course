// Enhanced Financial Management System with Auto-Processing on Startup
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

// Enum for recurrence types
enum RecurrenceType { daily, weekly, monthly, yearly }

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

// Enhanced Transaction class with recurring features
class Transaction {
  DateTime date;
  double amount;
  String from;
  String to;
  String description;
  Category category;

  // New fields for recurring transactions
  bool isRecurring;
  RecurrenceType? recurrenceType;
  int? recurringDay; // Day of month (1-31) or day of week (1-7)
  DateTime? nextDueDate;
  DateTime? endDate; // Optional end date for recurring transactions

  Transaction({
    DateTime? date,
    this.amount = 0.0,
    this.from = 'None',
    this.to = 'None',
    this.description = 'None',
    this.category = Category.other,
    this.isRecurring = false,
    this.recurrenceType,
    this.recurringDay,
    this.nextDueDate,
    this.endDate,
  }) : date = date ?? DateTime.now();

  @override
  String toString() {
    String result =
        'Date: ${date.toLocal()} | Amount: $amount | From: $from | To: $to | Description: $description | Category: $category';
    if (isRecurring) {
      result += ' | Recurring: ${recurrenceType.toString().split('.').last}';
      if (recurringDay != null) {
        result += ' on day $recurringDay';
      }
      if (nextDueDate != null) {
        result += ' | Next due: ${nextDueDate!.toLocal()}';
      }
    }
    return result;
  }
}

// Enhanced Account class with advanced recurring transaction handling
class Account with ImportMixin, ExportMixin {
  String name;
  int accountNumber;
  double balance;
  List<Transaction> income;
  List<Transaction> expenses;
  List<Transaction> recurringTransactions;

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

  // Enhanced method to add recurring transaction with scheduling
  void addRecurringTransaction(Transaction transaction) {
    if (!transaction.isRecurring) {
      throw ArgumentError('Transaction must be marked as recurring');
    }

    if (transaction.recurrenceType == null) {
      throw ArgumentError('Recurrence type must be specified');
    }

    // Calculate next due date if not provided
    if (transaction.nextDueDate == null) {
      transaction.nextDueDate = calculateNextDueDate(
        DateTime.now(),
        transaction.recurrenceType!,
        transaction.recurringDay,
      );
    }

    recurringTransactions.add(transaction);
    print('Recurring transaction added. Next due: ${transaction.nextDueDate}');
  }

  // Calculate next due date based on recurrence type and day
  DateTime calculateNextDueDate(
    DateTime currentDate,
    RecurrenceType type,
    int? day,
  ) {
    switch (type) {
      case RecurrenceType.daily:
        return currentDate.add(Duration(days: 1));

      case RecurrenceType.weekly:
        if (day == null || day < 1 || day > 7) {
          throw ArgumentError(
            'Weekly recurrence requires day of week (1-7, where 1=Monday)',
          );
        }
        int daysUntilTarget = (day - currentDate.weekday) % 7;
        if (daysUntilTarget == 0) daysUntilTarget = 7;
        return currentDate.add(Duration(days: daysUntilTarget));

      case RecurrenceType.monthly:
        if (day == null || day < 1 || day > 31) {
          throw ArgumentError(
            'Monthly recurrence requires day of month (1-31)',
          );
        }
        DateTime nextMonth = DateTime(
          currentDate.year,
          currentDate.month + 1,
          day,
        );
        if (nextMonth.month != currentDate.month + 1) {
          nextMonth = DateTime(currentDate.year, currentDate.month + 2, 0);
        }
        return nextMonth;

      case RecurrenceType.yearly:
        if (day == null) {
          return DateTime(
            currentDate.year + 1,
            currentDate.month,
            currentDate.day,
          );
        }
        return DateTime(currentDate.year + 1, currentDate.month, day);
    }
  }

  // Check if a transaction is due
  bool isTransactionDue(DateTime dueDate, DateTime currentDate) {
    return dueDate.isBefore(currentDate) ||
        (dueDate.year == currentDate.year &&
            dueDate.month == currentDate.month &&
            dueDate.day == currentDate.day);
  }

  // Enhanced process recurring transactions with scheduling
  void processRecurringTransactions() {
    final today = DateTime.now();
    int processedCount = 0;

    for (Transaction recurringTransaction in recurringTransactions) {
      if (recurringTransaction.nextDueDate == null) continue;

      if (isTransactionDue(recurringTransaction.nextDueDate!, today)) {
        try {
          Transaction newTransaction = Transaction(
            date: today,
            amount: recurringTransaction.amount,
            from: recurringTransaction.from,
            to: recurringTransaction.to,
            description: '${recurringTransaction.description} (Recurring)',
            category: recurringTransaction.category,
          );

          if (newTransaction.amount > 0) {
            addIncome(newTransaction);
          } else {
            addExpense(newTransaction);
          }

          recurringTransaction.nextDueDate = calculateNextDueDate(
            today,
            recurringTransaction.recurrenceType!,
            recurringTransaction.recurringDay,
          );

          processedCount++;
          print(
            'Processed recurring transaction: ${recurringTransaction.description}',
          );
          print('Next due date: ${recurringTransaction.nextDueDate}');
        } catch (e) {
          print(
            'Failed to process recurring transaction: ${recurringTransaction.description}',
          );
          print('Error: $e');
        }
      }
    }

    if (processedCount == 0) {
      print('No recurring transactions due today.');
    } else {
      print('Processed $processedCount recurring transactions.');
    }
  }

  // Get upcoming recurring transactions
  List<Transaction> getUpcomingRecurringTransactions([int days = 30]) {
    final cutoffDate = DateTime.now().add(Duration(days: days));
    final upcoming = <Transaction>[];

    for (Transaction transaction in recurringTransactions) {
      if (transaction.nextDueDate != null &&
          transaction.nextDueDate!.isBefore(cutoffDate)) {
        upcoming.add(transaction);
      }
    }

    upcoming.sort((a, b) => a.nextDueDate!.compareTo(b.nextDueDate!));
    return upcoming;
  }

  // Remove recurring transaction
  bool removeRecurringTransaction(int index) {
    if (index < 0 || index >= recurringTransactions.length) {
      return false;
    }
    recurringTransactions.removeAt(index);
    return true;
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
    print('Active Recurring Transactions: ${recurringTransactions.length}');
  }
}

void printCategory() {
  print('Categories');
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

// Updated menu without option 5 (since processing is automatic)
void printMenu() {
  print('1. Enter income');
  print('2. Enter expense');
  print('3. Show balance');
  print('4. Add recurring transaction');
  print('5. View transaction history');
  print('6. Filter transactions by category');
  print('7. Delete a transaction');
  print('8. View account summary');
  print('9. View category summary');
  print('10. Import transactions');
  print('11. Export transactions');
  print('12. View recurring transactions');
  print('13. Remove recurring transaction');
  print('14. Exit');
}

void printRecurrenceMenu() {
  print('Recurrence types:');
  print('1. Daily');
  print('2. Weekly');
  print('3. Monthly');
  print('4. Yearly');
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

RecurrenceType mapIntToRecurrenceType(int type) {
  switch (type) {
    case 1:
      return RecurrenceType.daily;
    case 2:
      return RecurrenceType.weekly;
    case 3:
      return RecurrenceType.monthly;
    case 4:
      return RecurrenceType.yearly;
    default:
      return RecurrenceType.monthly;
  }
}

// Enhanced function to add recurring transaction with user input
void addRecurringTransactionInteractive(Account account) {
  try {
    stdout.write("Enter recurring transaction amount: ");
    final amount = double.parse(stdin.readLineSync()!);

    stdout.write("Enter description: ");
    final description = stdin.readLineSync()!;

    stdout.write("Enter receiver: ");
    final fromTo = stdin.readLineSync()!;

    print("Select category:");
    printCategory();
    final categoryIndex = int.parse(stdin.readLineSync()!);
    final category = mapIntToCategory(categoryIndex);

    print("Select recurrence type:");
    printRecurrenceMenu();
    final recurrenceIndex = int.parse(stdin.readLineSync()!);
    final recurrenceType = mapIntToRecurrenceType(recurrenceIndex);

    int? recurringDay;

    switch (recurrenceType) {
      case RecurrenceType.weekly:
        stdout.write(
          "Enter day of week (1=Monday, 2=Tuesday, ..., 7=Sunday): ",
        );
        recurringDay = int.parse(stdin.readLineSync()!);
        if (recurringDay < 1 || recurringDay > 7) {
          throw ArgumentError('Day of week must be between 1 and 7');
        }
        break;

      case RecurrenceType.monthly:
        stdout.write("Enter day of month (1-31): ");
        recurringDay = int.parse(stdin.readLineSync()!);
        if (recurringDay < 1 || recurringDay > 31) {
          throw ArgumentError('Day of month must be between 1 and 31');
        }
        break;

      case RecurrenceType.yearly:
        stdout.write("Enter day of month for yearly recurrence (1-31): ");
        recurringDay = int.parse(stdin.readLineSync()!);
        break;

      case RecurrenceType.daily:
        break;
    }

    final transaction = Transaction(
      amount: amount,
      from: amount > 0 ? fromTo : 'Self',
      to: amount > 0 ? 'Self' : fromTo,
      description: description,
      category: category,
      isRecurring: true,
      recurrenceType: recurrenceType,
      recurringDay: recurringDay,
    );

    account.addRecurringTransaction(transaction);
    print("Recurring transaction added successfully!");
  } catch (e) {
    print("Error adding recurring transaction: $e");
  }
}

// Function to view recurring transactions
void viewRecurringTransactions(Account account) {
  if (account.recurringTransactions.isEmpty) {
    print("No recurring transactions found.");
    return;
  }

  print("Active Recurring Transactions:");
  for (int i = 0; i < account.recurringTransactions.length; i++) {
    print("[$i] ${account.recurringTransactions[i]}");
  }

  print("\nUpcoming in next 30 days:");
  final upcoming = account.getUpcomingRecurringTransactions();
  for (Transaction transaction in upcoming) {
    print("${transaction.description} - Due: ${transaction.nextDueDate}");
  }
}

// Function to remove recurring transaction
void removeRecurringTransactionInteractive(Account account) {
  if (account.recurringTransactions.isEmpty) {
    print("No recurring transactions to remove.");
    return;
  }

  print("Active Recurring Transactions:");
  for (int i = 0; i < account.recurringTransactions.length; i++) {
    print("[$i] ${account.recurringTransactions[i]}");
  }

  stdout.write("Enter the index of the recurring transaction to remove: ");
  try {
    final index = int.parse(stdin.readLineSync()!);
    if (account.removeRecurringTransaction(index)) {
      print("Recurring transaction removed successfully!");
    } else {
      print("Invalid index!");
    }
  } catch (e) {
    print("Invalid input!");
  }
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

// MAIN FUNCTION WITH AUTO-PROCESSING ON STARTUP
void main() {
  final account = Account(
    name: "Giang",
    accountNumber: 1234567,
    balance: 2000.00,
  );

  // AUTOMATICALLY PROCESS RECURRING TRANSACTIONS ON STARTUP
  print("Checking and processing due recurring transactions...");
  account.processRecurringTransactions();
  print("Auto-processing complete.\n");

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
        addRecurringTransactionInteractive(account);
        break;

      case "5":
        print("Transaction History:");
        for (var transaction in account.getAllTransactions()) {
          print(transaction);
        }
        break;

      case "6":
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

      case "7":
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

      case "8":
        account.printSummary();
        break;

      case "9":
        print("Category Summary:");
        final categorySummary = account.getCategorySummary();

        categorySummary.forEach((category, total) {
          print("Category: $category, Total: $total");
        });
        break;

      case "10":
        importTransactions(account);
        break;

      case "11":
        exportTransactions(account);
        break;

      case "12":
        viewRecurringTransactions(account);
        break;

      case "13":
        removeRecurringTransactionInteractive(account);
        break;

      case "14":
        print("Exiting the program.");
        return;

      default:
        print("Invalid option, please try again.");
    }
  }
}
