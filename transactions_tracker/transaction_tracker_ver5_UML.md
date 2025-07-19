```mermaid
classDiagram
    %% Enum Definition
    class Category {
        <<enumeration>>
        +FOOD
        +GAS
        +HOUSING
        +TUITION
        +MARKET
        +ELECTRICITY_BILL
        +UTILITIES
        +RESTAURANT
        +INSURANCE
        +SALARY
        +GAME
        +OTHER
    }

    %% Mixins
    class ImportMixin {
        <<mixin>>
        +importFromCSV(String csvData) void
    }

    class ExportMixin {
        <<mixin>>
        +exportToCSV() String
    }

    %% Main Classes
    class Transaction {
        -DateTime date
        -double amount
        -String from
        -String to
        -String description
        -Category category
        +Transaction(DateTime? date, double amount, String from, String to, String description, Category category)
        +toString() String
    }

    class Account {
        -String name
        -int accountNumber
        -double balance
        -List~Transaction~ income
        -List~Transaction~ expenses
        -List~Transaction~ recurringTransactions
        +Account(String name, int accountNumber, double balance, List~Transaction~? income, List~Transaction~? expenses, List~Transaction~? recurringTransactions)
        +addIncome(Transaction transaction) void
        +addExpense(Transaction transaction) void
        +addRecurringTransaction(Transaction transaction) void
        +processRecurringTransactions() void
        +getBalance() double
        +getAllTransactions() List~Transaction~
        +filterTransactionsByCategory(Category category) List~Transaction~
        +getCategorySummary() Map~Category, double~
        +getTransactionsByDate(DateTime date) List~Transaction~
        +deleteTransactionByDateAndIndex(DateTime date, int index) bool
        +printSummary() void
    }

    %% Utility Functions (represented as a utility class)
    class UtilityFunctions {
        <<utility>>
        +printCategory() void
        +printMenu() void
        +mapIntToCategory(int categorynumber) Category
        +importTransactions(Account account) void
        +exportTransactions(Account account) void
        +main() void
    }

    %% Relationships
    Account --|> ImportMixin : implements
    Account --|> ExportMixin : implements
    Account "1" *-- "0..*" Transaction : contains income
    Account "1" *-- "0..*" Transaction : contains expenses
    Account "1" *-- "0..*" Transaction : contains recurring
    Transaction --> Category : uses
    UtilityFunctions ..> Account : uses
    UtilityFunctions ..> Category : uses
    UtilityFunctions ..> Transaction : creates
    ```