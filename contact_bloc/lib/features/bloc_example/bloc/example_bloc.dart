import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleStateInicial()) {
    on<ExampleFindNameEvent>(_findNames);
  }

  FutureOr<void> _findNames(
    ExampleFindNameEvent event,
    Emitter<ExampleState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 5));
  
    final names = [
      'Carlos Alberto',
      'Cristiane Oliveira',
      'Flutter',
      'Dart',
      'Flutter Bloc'
    ];

    emit(ExampleStateData(names: names));
  }
}
