// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'example_bloc.dart';

@immutable
abstract class ExampleState {

}

class ExampleStateInicial extends ExampleState {}

class ExampleStateData extends ExampleState {
  final List<String> name;

  ExampleStateData({
    required this.name,
  });
  
}
