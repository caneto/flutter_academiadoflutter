
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_example/app/categoria/model/preco_model.dart';

class CategoriaController implements Disposable {
  PrecoModel precoModel;
  CategoriaController({required this.precoModel}) {
    print('Categoria Controller $hashCode');
  }
  
  @override
  void dispose() {
    
  } 
}