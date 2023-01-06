
import 'dart:async';
import 'dart:math';

import 'imc_state.dart';

class ImcBlocPatternController {
  final _imcStreamController = StreamController<ImcState>.broadcast()..add(ImcState(imc: 0)); 
  Stream<ImcState> get ImcOut => _imcStreamController.stream;

  Future<void> calcularImc({required double peso, required double altura})  async {
    _imcStreamController.add(ImcStateLoading());
    await Future.delayed(const Duration(seconds: 1));

    final imc = peso / pow(altura,2); 

    _imcStreamController.add(ImcState(imc: imc));
  }

  void dispose() {
    _imcStreamController.close();
  }

}