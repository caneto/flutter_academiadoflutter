import 'package:cuidapet_api/config/database_connection.dart';
import 'package:cuidapet_api/controllers/fornecedores/dto/salvar_fornecedor_request.dart';
import 'package:cuidapet_api/models/categorias_model.dart';
import 'package:cuidapet_api/models/fornecedor_model.dart';
import 'package:cuidapet_api/models/fornecedor_servicos_model.dart';
import 'package:cuidapet_api/utils/cripty_utils.dart';
import 'package:mysql1/mysql1.dart';

class FornecedoresRepository {
  Future<List<Map<String, dynamic>>> buscarFornecedoresProximo(double lat, double lng, int distancia) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query(''' 
        SELECT f.id, f.nome, f.logo, f.categorias_fornecedor_id,
          (6371 *
            acos(
                            cos(radians($lat)) *
                            cos(radians(ST_X(f.latlng))) *
                            cos(radians($lng) - radians(ST_Y(f.latlng))) +
                            sin(radians($lat)) *
                            sin(radians(ST_X(f.latlng)))
                )) AS distancia
            FROM fornecedor f
            HAVING distancia <= $distancia order by distancia ASC;
      ''');

      return result
          .map((e) => e.fields)
          .map(
            (e) => {
              'id': e['id'] as int,
              'nome': e['nome'] as String,
              'logo': (e['logo'] as Blob)?.toString(),
              'distancia': e['distancia'] as double,
              'categoria': {'id': e['categorias_fornecedor_id'] as int}
            },
          )
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<FornecedorModel> recuperarPorId(int id) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query(''' 
        select f.id, f.nome, f.logo, f.endereco, f.telefone, ST_X(f.latlng) as lat, ST_Y(f.latlng) as lng, f.categorias_fornecedor_id
            , c.id, c.nome_categoria, c.tipo_categoria
        from fornecedor as f
        inner join categorias_fornecedor as c on (f.categorias_fornecedor_id = c.id)
        where f.id = ?
      ''', [id]);

      final data = result.first.fields;
      return FornecedorModel(
        id: data['id'] as int,
        nome: data['nome'] as String,
        logo: (data['logo'] as Blob)?.toString(),
        endereco: data['endereco'] as String,
        telefone: data['telefone'] as String,
        latitude: data['lat'] as double,
        longitude: data['lng'] as double,
        categoria: CategoriaModel(
          id: data['categorias_fornecedor_id'] as int,
          nome: data['nome_categoria'] as String,
          tipo: data['tipo_categoria'] as String,
        ),
      );
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<List<FornecedorServicosModel>> buscarTodosServicos(int fornecedorId) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query(''' 
        select id, fornecedor_id, nome_servico, valor_servico
        from fornecedor_servicos
        where fornecedor_id = ?;
      ''', [fornecedorId]);

      return result
          .map((e) => e.fields)
          .map(
            (data) => FornecedorServicosModel(
              id: data['id'] as int,
              fornecedorId: data['fornecedor_id'] as int,
              nome: data['nome_servico'] as String,
              valor: data['valor_servico'] as double,
            ),
          )
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<void> criarFornecedor(SalvarFornecedorRequest fornecedor) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      await conn.transaction((_) async {
        final result = await conn.query(
          "insert into fornecedor(id, nome, logo, endereco, telefone, latlng) values(?,?,?,?,?,?,Point(?,?))",
          [null, fornecedor.nome, fornecedor.logo, fornecedor.endereco, fornecedor.telefone, fornecedor.latitude, fornecedor.longitude],
        );

        final idFornecedor = result.insertId;

        await conn.query(
          "insert usuario(email, tipo_cadastro, senha, img_avatar, fornecedor_id) values(?, ?, ?, ?, ?)",
          [fornecedor.usuario, 'APP', CriptyUtils.generateSHA256Hash(fornecedor.senha), fornecedor.logo, idFornecedor],
        );
      });
    } on MySqlException catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn?.close();
    }
  }
}
