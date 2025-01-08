import 'package:macros/macros.dart';

macro class ToString {
  const ToString();
  
  static void build(ClassDeclaration clazz, MemberDeclarationBuilder builder) {
    final className = clazz.identifier.name;
    final fields = clazz.fields;
    
    final buffer = StringBuffer();
    buffer.write('$className(');
    
    for (var i = 0; i < fields.length; i++) {
      final field = fields[i];
      buffer.write('${field.identifier.name}: \${${field.identifier.name}}');
      if (i < fields.length - 1) {
        buffer.write(', ');
      }
    }
    
    buffer.write(')');
    
    builder.declareInType(DeclarationCode.fromString('''
      @override
      String toString() {
        return '${buffer.toString()}';
      }
    '''));
  }
}

@ToString()
class Person {
  final String name;
  final int age;
  
  Person(this.name, this.age);
}

int calculate() {
  return 6 * 7;
}
