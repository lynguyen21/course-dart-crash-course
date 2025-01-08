import 'package:test/test.dart';
import '../lib/macros_experiment.dart';

void main() {
  group('Transaction JSON Serialization', () {
    test('should serialize to JSON correctly', () {
      final transaction = Transaction(
        date: DateTime(2023, 1, 1),
        amount: 100.0,
        from: 'Employer',
        to: 'Bank',
        description: 'Salary',
        category: Category.salary,
      );

      final json = transaction.toJson();

      expect(json['date'], '2023-01-01T00:00:00.000');
      expect(json['amount'], 100.0);
      expect(json['from'], 'Employer');
      expect(json['to'], 'Bank');
      expect(json['description'], 'Salary');
      expect(json['category'], 'salary');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'date': '2023-01-01T00:00:00.000',
        'amount': 100.0,
        'from': 'Employer',
        'to': 'Bank',
        'description': 'Salary',
        'category': 'salary',
      };

      final transaction = Transaction.fromJson(json);

      expect(transaction.date, DateTime(2023, 1, 1));
      expect(transaction.amount, 100.0);
      expect(transaction.from, 'Employer');
      expect(transaction.to, 'Bank');
      expect(transaction.description, 'Salary');
      expect(transaction.category, Category.salary);
    });
  });

  group('Account JSON Serialization', () {
    test('should serialize to JSON correctly', () {
      final account = Account(
        name: 'Test Account',
        accountNumber: 123456,
        balance: 1000.0,
      );

      final json = account.toJson();

      expect(json['name'], 'Test Account');
      expect(json['accountNumber'], 123456);
      expect(json['balance'], 1000.0);
      expect(json['income'], isA<List>());
      expect(json['expenses'], isA<List>());
      expect(json['recurringTransactions'], isA<List>());
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'name': 'Test Account',
        'accountNumber': 123456,
        'balance': 1000.0,
        'income': [],
        'expenses': [],
        'recurringTransactions': [],
      };

      final account = Account.fromJson(json);

      expect(account.name, 'Test Account');
      expect(account.accountNumber, 123456);
      expect(account.balance, 1000.0);
      expect(account.income, isEmpty);
      expect(account.expenses, isEmpty);
      expect(account.recurringTransactions, isEmpty);
    });
  });
}
