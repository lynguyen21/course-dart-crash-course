import 'package:macros/macros.dart';

macro class ToString {
  const ToString();
  
  static void build(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final className = clazz.identifier.name;
    final fields = await builder.fieldsOf(clazz);
    
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
