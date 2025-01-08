// Macro to print categories
void printCategory() {
  const categories = [
    'food',
    'gas',
    'housing',
    'tuition',
    'market',
    'electricity bill',
    'utilities',
    'restaurant',
    'insurance',
    'salary',
    'game',
    'other',
  ];

  print('Select category:');
  for (var i = 0; i < categories.length; i++) {
    print('\${i + 1}. \${categories[i]}');
  }
}

// Macro to map category number to enum
Category mapIntToCategory(int categoryNumber) {
  return Category.values[categoryNumber - 1];
}

// Macro to create and add transactions
void handleTransaction({
  required String type,
  required Function(Transaction) addFunction,
  required String prompt,
}) {
  stdout.write("Enter \$type amount: ");
  final amount = double.parse(stdin.readLineSync()!);
  stdout.write("Enter \$prompt: ");
  final party = stdin.readLineSync()!;
  stdout.write("Enter description: ");
  final description = stdin.readLineSync()!;
  stdout.write("Enter category: \n");
  printCategory();
  final category = int.parse(stdin.readLineSync()!);

  addFunction(
    Transaction(
      amount: amount,
      description: description,
      category: mapIntToCategory(category),
      from: type == 'income' ? party : 'None',
      to: type == 'expense' ? party : 'None',
    ),
  );

  print("\u2713 \$type added successfully!\n");
}

// Macro to process and print transactions
void printFilteredTransactions(Account account) {
  stdout.write("Enter category to filter: \n");
  printCategory();
  final category = int.parse(stdin.readLineSync()!);
  final filteredTransactions = account.filterTransactionsByCategory(
    mapIntToCategory(category),
  );

  print("Filtered Transactions:\n");
  for (var transaction in filteredTransactions) {
    print(transaction);
  }
}

// Macro for deleting transactions
void deleteTransactionPrompt(Account account) {
  stdout.write("Enter transaction type (income/expense): ");
  final type = stdin.readLineSync()!.toLowerCase();

  if (type != 'income' && type != 'expense') {
    print("Invalid transaction type!");
    return;
  }

  stdout.write("Enter transaction date (yyyy-MM-dd HH:MM): ");
  final date = DateTime.parse(stdin.readLineSync()!);
  stdout.write("Enter transaction amount: ");
  final amount = double.parse(stdin.readLineSync()!);

  if (account.deleteTransaction(date, amount, type)) {
    print("Transaction deleted successfully!\n");
  } else {
    print("Transaction not found!\n");
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
        handleTransaction(
          type: 'income',
          addFunction: account.addIncome,
          prompt: 'sender',
        );
        break;

      case "2":
        handleTransaction(
          type: 'expense',
          addFunction: account.addExpense,
          prompt: 'receiver',
        );
        break;

      case "3":
        print("Current balance: \${account.getBalance()}\n");
        break;

      case "4":
        handleTransaction(
          type: 'recurring transaction',
          addFunction: account.addRecurringTransaction,
          prompt: 'party',
        );
        break;

      case "5":
        account.processRecurringTransactions();
        print("Recurring transactions processed.\n");
        break;

      case "6":
        print("Transaction History:\n");
        for (var transaction in account.getAllTransactions()) {
          print(transaction);
        }
        break;

      case "7":
        printFilteredTransactions(account);
        break;

      case "8":
        deleteTransactionPrompt(account);
        break;

      case "9":
        account.printSummary();
        break;

      case "10":
        print("Category Summary:\n");
        final categorySummary = account.getCategorySummary();

        categorySummary.forEach((category, total) {
          print("Category: \$category, Total: \$total\n");
        });
        break;

      case "11":
        print("Exiting the program.\n");
        return;

      default:
        print("Invalid option, please try again.\n");
    }
  }
}
