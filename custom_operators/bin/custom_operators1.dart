// // Family member operator
// void main(List<String> args) {
//   final dad = FamilyMember(name: 'Dad');
//   final mom = FamilyMember(name: 'Mom');
//   final family = dad + mom;
//   print(family);
// }

// class FamilyMember {
//   // Represents a single person in the family.
//   final String name;

//   const FamilyMember({required this.name});

//   @override
//   String toString() => 'Family member (name = $name)';
// }

// class Family {
//   final List<FamilyMember> members;

//   const Family({required this.members});

//   @override
//   String toString() => 'Family (members = $members)';
// }

// extension ToFamily on FamilyMember {
//   /// This will override '+' operator so that Family = this 'FamilyMember' + other 'FamilyMember'
//   Family operator +(FamilyMember other) => Family(members: [this, other]);
// }

class FamilyMember {
  final String name;
  const FamilyMember({required this.name});

  @override
  String toString() => 'Family member (name = $name)';
}

class Family {
  final List<FamilyMember> members;
  const Family({required this.members});

  @override
  String toString() => 'Family (members = $members)';
}

extension ToFamily on FamilyMember {
  Family operator +(FamilyMember other) => Family(members: [this, other]);
}

// Multiplying an Iterable
// repeat the contents of a collection using the * operator

extension Times<T> on Iterable<T> {
  Iterable<T> operator *(int times) sync* {
    for (var i = 0; i < times; i++) {
      yield* this;
    }
  }
}

void main(List<String> args) {
  final dad = FamilyMember(name: 'Que');
  final mom = FamilyMember(name: 'Thu');

  final family = dad + mom;
  print(family);

  print('---');
  const names = ['Seth', 'Kathy', 'Ethan', 'Megan'];
  print(names * 3);
}
