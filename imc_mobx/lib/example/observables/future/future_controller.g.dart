// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FutureController on FutureControllerBase, Store {
  late final _$nomeFutureAtom =
      Atom(name: 'FutureControllerBase.nomeFuture', context: context);

  @override
  ObservableFuture<String> get nomeFuture {
    _$nomeFutureAtom.reportRead();
    return super.nomeFuture;
  }

  @override
  set nomeFuture(ObservableFuture<String> value) {
    _$nomeFutureAtom.reportWrite(value, super.nomeFuture, () {
      super.nomeFuture = value;
    });
  }

  late final _$buscarNomeAsyncAction =
      AsyncAction('FutureControllerBase.buscarNome', context: context);

  @override
  Future<void> buscarNome() {
    return _$buscarNomeAsyncAction.run(() => super.buscarNome());
  }

  @override
  String toString() {
    return '''
nomeFuture: ${nomeFuture}
    ''';
  }
}
