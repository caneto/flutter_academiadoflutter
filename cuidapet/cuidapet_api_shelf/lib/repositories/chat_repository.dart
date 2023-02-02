import 'package:cuidapet_api/config/database_connection.dart';
import 'package:cuidapet_api/models/chat_model.dart';
import 'package:cuidapet_api/models/fornecedor_model.dart';
import 'package:cuidapet_api/models/usuario_model.dart';
import 'package:cuidapet_api/repositories/usuario_repository.dart';
import 'package:mysql1/mysql1.dart';

class ChatRepository {
  final UsuarioRepository _usuarioRepository = UsuarioRepository();

  Future<List<ChatModel>> buscarChatsUsuario(int usuario) async {
    MySqlConnection conn;
    final usuarioData = await _usuarioRepository.getById(usuario);
    try {
      conn = await DatabaseConnection.openConnection();
      var query = ''' 
        select c.id, c.data_criacao, c.status, a.nome, a.nome_pet, a.fornecedor_id, f.nome, f.logo, a.usuario_id
        from chats as c
          inner join agendamento a on c.agendamento_id = a.id
          inner join fornecedor f on a.fornecedor_id = f.id
      ''';

      int usuarioId;

      if (usuarioData.fornecedorId == null) {
        usuarioId = usuario;
        query += 'where a.usuario_id = ?';
      } else {
        usuarioId = usuarioData.fornecedorId; 
        query += 'where a.fornecedor_id = ?';
      }

      query += '''
        and c.status = 'A'
        order by c.data_criacao  
      ''';

      final result = await conn.query(query, [usuarioId]);
      print(result.length);
      return result.map((e) {
        return ChatModel(id: e[0] as int, status: e[2] as String, nome: e[3] as String, nomePet: e[4] as String, fornecedor: FornecedorModel(id: e[5] as int, nome: e[6] as String, logo: (e[7] as Blob).toString()), usuario: e[8] as int);
      }).toList();
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<List<ChatModel>> buscarChatsFornecedor(int fornecedor) async {
    MySqlConnection conn;
    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query(''' 
        select c.id, c.data_criacao, c.status, a.nome, a.nome_pet, a.fornecedor_id, f.nome, f.logo, a.usuario_id
        from chats as c
          inner join agendamento a on c.agendamento_id = a.id
          inner join fornecedor f on a.fornecedor_id = f.id
        where a.fornecedor_id = ?
        and c.status = 'A'
        order by c.data_criacao
      ''', [fornecedor]);
      return result.map((e) {
        return ChatModel(
          id: e[0] as int,
          status: e[2] as String,
          nome: e[3] as String,
          nomePet: e[4] as String,
          fornecedor: FornecedorModel(id: e[5] as int, nome: e[6] as String, logo: (e[7] as Blob).toString()),
          usuario: e[8] as int,
        );
      }).toList();
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<ChatModel> recuperarPorId(int id) async {
    MySqlConnection conn;
    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query(''' 
        select c.id, c.data_criacao, c.status, a.nome, a.nome_pet, a.fornecedor_id, f.nome, f.logo, a.usuario_id
        from chats as c
          inner join agendamento a on c.agendamento_id = a.id
          inner join fornecedor f on a.fornecedor_id = f.id
        where c.id = ?;
      ''', [id]);
      final e = result.first;
      return ChatModel(
        id: e[0] as int,
        status: e[2] as String,
        nome: e[3] as String,
        nomePet: e[4] as String,
        fornecedor: FornecedorModel(id: e[5] as int, nome: e[6] as String, logo: (e[7] as Blob).toString()),
        usuario: e[8] as int,
      );
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<List<String>> recuperarDeviceIdPorChat(int id, String usuarioTipo) async {
    MySqlConnection conn;
    final UsuarioRepository usuarioRepository = UsuarioRepository();

    try {
      conn = await DatabaseConnection.openConnection();
      final usuarios = await conn.query('''
          select a.usuario_id, a.fornecedor_id from chats as c
          inner join agendamento a on c.agendamento_id = a.id
          where c.id=?
      ''', [id]);

      UsuarioModel usuario;

      if (usuarioTipo == 'U') {
        usuario = await usuarioRepository.getById(usuarios.first[0] as int);
      } else {
        usuario = await usuarioRepository.getByFornecedorId(usuarios.first[1] as int);
      }

      return [usuario.androidToken, usuario.iosToken];
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<void> closeChat(int id) async {
    MySqlConnection conn;
    try {
      conn = await DatabaseConnection.openConnection();
      await conn.query(''' 
        update chats set status = 'F' where id = ?
      ''', [id]);
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<int> iniciarChat(int agendamento) async {
    MySqlConnection conn;
    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query(''' 
        insert into chats(agendamento_id, status, data_criacao) values(?,?,?)
      ''', [agendamento, 'A', DateTime.now().toIso8601String()]);
      return result.insertId;
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }
}
