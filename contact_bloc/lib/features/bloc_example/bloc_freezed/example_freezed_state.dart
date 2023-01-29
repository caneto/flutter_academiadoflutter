part of 'example_freezed_bloc.dart';

@freezed
abstract class ExampleFreezedState with _$ExampleFreezedState {
  factory ExampleFreezedState.initial() = _ExampleFreezedStateInitial;
  factory ExampleFreezedState.loading() = _ExampleFreezedStateLoading;
  factory ExampleFreezedState.showBanner({
    required List<String> names,
    required String message,
  }) = _ExampleFreezedStateBanner;
  factory ExampleFreezedState.data({required List<String> names}) =
      _ExampleFreezedStateData;
}
