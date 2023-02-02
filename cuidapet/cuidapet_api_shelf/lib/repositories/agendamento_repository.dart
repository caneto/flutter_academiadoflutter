import 'package:cuidapet_api/config/database_connection.dart';
import 'package:cuidapet_api/controllers/agendamento/dto/agendar_servico_rq.dart';
import 'package:cuidapet_api/models/agendamento_model.dart';
import 'package:cuidapet_api/models/fornecedor_model.dart';
import 'package:cuidapet_api/models/fornecedor_servicos_model.dart';
import 'package:mysql1/mysql1.dart';

class AgendamentoRepository {
  Future<void> agendar(int usuario, AgendarServicoRQ agendarServicoRQ) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      await conn.transaction((_) async {
        final result = await conn.query(''' 
            insert into 
              agendamento(id, data_agendamento, usuario_id, fornecedor_id, status, nome, nome_pet) 
              values(?, ?, ?, ?, ?, ?, ?)
            ''', [
          null,
          agendarServicoRQ.dataAgendamento.toIso8601String(),
          usuario,
          agendarServicoRQ.fornecedorId,
          'P',
          agendarServicoRQ.nome,
          agendarServicoRQ.nomePet,
        ]);

        final agendamentoId = result.insertId;
        final params = agendarServicoRQ.servicos.map((e) => [agendamentoId, e]).toList();
        await conn.queryMulti('insert into agendamento_servicos values(?, ?)', params);
      });
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<List<AgendamentoModel>> buscarTodosAgendamentos(int usuarioId) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query('''
        select a.*, f.*
          from agendamento as a
          inner join fornecedor f on a.fornecedor_id = f.id
        where usuario_id = ?;
      ''', [usuarioId]);

      return Future.wait(result.map(
        (e) async {
          return AgendamentoModel(
            id: e[0] as int,
            dataAgendamento: e[1] as DateTime,
            status: e[4] as String,
            nome: e[5] as String,
            nomePet: e[6] as String,
            fornecedor: FornecedorModel(
              id: e[7] as int,
              nome: e[8] as String,
              logo: (e[9] as Blob).toString(),
            ),
            servicos: await buscarServicosDeUmAgendamento(e[0] as int),
          );
        },
      ).toList());
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }
  
  Future<List<AgendamentoModel>> buscarTodosAgendamentosFornecedor(int fornecedorId) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query('''
        select a.*, f.*
          from agendamento as a
          inner join fornecedor f on a.fornecedor_id = f.id
        where a.fornecedor_id = ?;
      ''', [fornecedorId]);

      return Future.wait(result.map(
        (e) async {
          return AgendamentoModel(
            id: e[0] as int,
            dataAgendamento: e[1] as DateTime,
            status: e[4] as String,
            nome: e[5] as String,
            nomePet: e[6] as String,
            fornecedor: FornecedorModel(
              id: e[7] as int,
              nome: e[8] as String,
              logo: (e[9] as Blob).toString(),
            ),
            servicos: await buscarServicosDeUmAgendamento(e[0] as int),
          );
        },
      ).toList());
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<List<FornecedorServicosModel>> buscarServicosDeUmAgendamento(int agendamento) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query('''
        select fs.id, fs.nome_servico, fs.valor_servico
        from agendamento_servicos as ag
        inner join fornecedor_servicos fs on ag.fornecedor_servicos_id = fs.id
        where ag.agendamento_id = ?;
      ''', [agendamento]);

      return result.map(
        (e) {
          return FornecedorServicosModel(
            id: e[0] as int,
            nome: e[1] as String,
            valor: e[2] as double,
          );
        },
      ).toList();
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<void> alterarStatus(int agendamento, String status) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      await conn.transaction((_) async {
        await conn.query(''' 
            update 
              agendamento set status = ?
              where id = ?
            ''', [status, agendamento]);
      });
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<Map<String,String>> getTokenUsuarioMensagem(int agendamento) async {
    MySqlConnection conn;

    try {
      conn = await DatabaseConnection.openConnection();
      final result = await conn.query('''
        select u.ios_token, u.android_token from agendamento a
        inner join usuario u on a.usuario_id = u.id
        where a.id = ?
      ''', [agendamento]);

      final r = result.first;
      return {
        'ios': (r[0] as Blob)?.toString(),
        'android': (r[1] as Blob)?.toString(),
      };
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      await conn.close();
    }
  }
}
