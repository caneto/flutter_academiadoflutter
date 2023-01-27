import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleStateInicial()) {
    on<ExampleAddNameEvent>(_addName);
    on<ExampleFindNameEvent>(_findNames);
    on<ExampleRemoveAddNameEvent>(_removeName);
  }

  FutureOr<void> _addName(
    ExampleAddNameEvent event,
    Emitter<ExampleState> emit,
  ) {

    final stateExample = state;

    // Simplificado
    if(stateExample is ExampleStateData) {
      final names = [...stateExample.names];
      //Filtro em fart
      names.add(event.name);
      //names.retainWhere((element) => element != event.name);
      emit(ExampleStateData(names: names));
    }
  }

  FutureOr<void> _removeName(
    ExampleRemoveAddNameEvent event,
    Emitter<ExampleState> emit,
  ) {

    // Variavel local faz auto promoção sem precisar co cascate.
    final stateExample = state;

    //if(state is ExampleStateData) {
    //  (state as ExampleStateData).names;
    //}

    // Simplificado
    if(stateExample is ExampleStateData) {
      final names = [...stateExample.names];
      //Filtro em fart
      names.retainWhere((element) => element != event.name);
      emit(ExampleStateData(names: names));
    }
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
