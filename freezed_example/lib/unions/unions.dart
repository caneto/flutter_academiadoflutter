
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unions.freezed.dart';

@freezed
class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}

void main() {
  var example = Example.person('Carlos Alberto', 57);

  example.name;

  if(example is Person) {
    example.age;
  }
}