// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImcController on ImcControllerBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: 'ImcControllerBase.hasError'))
          .value;

  late final _$imcAtom = Atom(name: 'ImcControllerBase.imc', context: context);

  @override
  double get imc {
    _$imcAtom.reportRead();
    return super.imc;
  }

  @override
  set imc(double value) {
    _$imcAtom.reportWrite(value, super.imc, () {
      super.imc = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'ImcControllerBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$calcularImcAsyncAction =
      AsyncAction('ImcControllerBase.calcularImc', context: context);

  @override
  Future<void> calcularImc({required double peso, required double altura}) {
    return _$calcularImcAsyncAction
        .run(() => super.calcularImc(peso: peso, altura: altura));
  }

  @override
  String toString() {
    return '''
imc: ${imc},
error: ${error},
hasError: ${hasError}
    ''';
  }
}
