##  Flutter's Features Applied in Application

**1. App Structure & Navigation**

```
# main() method
void main() { runApp(...); }

# MaterialApp
MaterialApp(title: ..., home: ...)

# StatelessWidget
class TransactionApp extends StatelessWidget

# Scaffold
Scaffold(appBar: ..., body: ...)

```

**2. State Management with Riverpod**

```
# ProviderScope
runApp(ProviderScope(...))

# Provider
final accountProvider = Provider(...)

# ConsumerWidget
class TransactionHomePage extends ConsumerWidget

# ConsumerStatefulWidget
class AddTransactionPage extends ConsumerStatefulWidget

# ref.read() / ref.watch()
ref.read(accountProvider)
```
**3. Form Handling**

```
# Form widget
Form(key: _formKey, child: ...)

# TextFormField
TextFormField(controller: ..., validator: ...)

# DropdownButtonFormField
DropdownButtonFormField<Category>(...)

# GlobalKey<FormState>
_formKey = GlobalKey<FormState>()

```

**4. Navigation**
