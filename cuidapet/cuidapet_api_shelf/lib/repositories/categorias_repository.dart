import 'package:cuidapet_api/config/database_connection.dart';
import 'package:cuidapet_api/cuidapet_api.dart';
import 'package:cuidapet_api/models/categorias_model.dart';
import 'package:mysql1/mysql1.dart';

class CategoriasRepository {
  Future<List<CategoriaModel>> findAll() async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query('select * from categorias_fornecedor');
      return result
          .map(
            (e) => CategoriaModel(id: e[0] as int, nome: e[1] as String, tipo: e[2] as String),
          )
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }
}
