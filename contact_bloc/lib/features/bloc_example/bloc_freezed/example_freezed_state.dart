part of 'example_freezed_bloc.dart';

@freezed
abstract class ExampleFreezedState with _$ExampleFreezedState {
   factory ExampleFreezedState.initial() = _ExampleFreezedStateInitial;
   factory ExampleFreezedState.data({required List<String> name}) = _ExampleFreezedStateData;
}