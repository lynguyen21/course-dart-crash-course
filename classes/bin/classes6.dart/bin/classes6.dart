// Mixins

// Ideas:
// In Dart, mixins are a powerful feature that allows you to reuse code across multiple classes without requiring inheritance.
// Mixins provide a way to extend the functionality of a class by "mixing in" additional behaviors.
// They were introduced to address the limitations of single inheritance and promote code reuse.

// Simple Mixins
// To create a mixin, define a class with the mixin keyword instead of class.
// Mixins can inherit from other classes, extend other mixins, or implement interfaces.

/// A mixin representing an entity with speed.
// mixin HasSpeed {
//   /// The speed of the entity.
//   /// HasSpeed requires to have the speed as its required property
//   /// [abstract] here is to tell its sub classes to provide the value for this property.
//   abstract double speed;
// }

// /// A mixin representing an entity that can jump.
// /// Mixins cannot have constructors, so they cannot initialize instance variables.
// // By making speed abstract, we ensure that any class mixing in HasSpeed must provide a concrete implementation of speed.
// mixin CanJump on HasSpeed {
//   /// Makes the entity jump at a specified speed.
//   void jump({required double speed}) {
//     print('$runtimeType is jumping at the speed of $speed');
//   }
// }

// /// A class representing a person who can have speed and jump.
// class Person with HasSpeed, CanJump {
//   @override
//   double speed;

//   /// Constructs a person with an initial speed of 0.0.
//   Person() : speed = 0.0;
// }

// void main(List<String> args) {
//   final person = Person();

//   /// Make the person jump with a speed of 10.0.
//   person.jump(speed: 10.0);
// }

mixin HasSpeed {
  abstract double speed;
}

mixin CanJump on HasSpeed {
  void jump({required double speed}) {
    print('$runtimeType is jumping at the speed of $speed');
  }
}

class Person with HasSpeed, CanJump {
  @override
  double speed;
  Person() : speed = 0.0;
}

void main(List<String> args) {
  Person person = Person();
  person.jump(speed: 10.1);
}
