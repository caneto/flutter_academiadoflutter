import 'package:cuidapet_api/application/exceptions/database_exception.dart';
import 'package:cuidapet_api/entities/schedule_supplier_service.dart';
import 'package:cuidapet_api/entities/supplier.dart';
import 'package:cuidapet_api/entities/supplier_service.dart';
import 'package:injectable/injectable.dart';

import 'package:cuidapet_api/application/database/i_database_connection.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/entities/schedule.dart';
import 'package:mysql1/mysql1.dart';

import './i_schedule_repository.dart';

@LazySingleton(as: IScheduleRepository)
class ScheduleRepository implements IScheduleRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  ScheduleRepository({
    required this.connection,
    required this.log,
  });

  @override
  Future<void> save(Schedule schedule) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      await conn.transaction((_) async {
        final result = await conn!.query('''
          insert into
            agendamento(data_agendamento, usuario_id, fornecedor_id, status, nome, nome_pet) 
          values(
            ?,?,?,?,?,?
          )
        ''', [
          schedule.scheduleDate.toIso8601String(),
          schedule.userId,
          schedule.supplier.id,
          schedule.status,
          schedule.name,
          schedule.petName
        ]);

        final scheduleId = result.insertId;

        if (scheduleId != null) {
          await conn.queryMulti('''
            insert into agendamento_servicos values(?, ?)
          ''', schedule.services.map((s) => [scheduleId, s.service.id]));
        }
      });
    } on MySqlException catch (e, s) {
      log.error('Erro ao agendar servico', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> changeStatus(String status, int scheduleId) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      await conn.query('''
        update 
          agendamento set status = ?
        where
          id = ?
      ''', [status, scheduleId]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao alterar status de um agendamento', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<Schedule>> findAllSchedulesByUser(int userId) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final query = '''
        select 
          a.id,
          a.data_agendamento,
          a.status,
          a.nome,
          a.nome_pet,
          f.id as fornec_id,
          f.nome as fornec_nome,
          f.logo
        from agendamento as a
        inner join fornecedor f on f.id = a.fornecedor_id
        where a.usuario_id = ?
        order by a.data_agendamento desc
      ''';

      final result = await conn.query(query, [userId]);

      final scheduleResultFuture = result
          .map(
            (s) async => Schedule(
              id: s['id'],
              scheduleDate: s['data_agendamento'],
              status: s['status'],
              name: s['nome'],
              petName: s['nome_pet'],
              userId: userId,
              supplier: Supplier(
                id: s['fornec_id'],
                logo: (s['logo'] as Blob?).toString(),
                name: s['fornec_nome'],
              ),
              services: await findAllServicesBySchedule(s['id']),
            ),
          )
          .toList();

      return Future.wait(scheduleResultFuture);
    } on MySqlException catch (e, s) {
      log.error('Erro buscar agendamentos de um usuário', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  Future<List<ScheduleSupplierService>> findAllServicesBySchedule(
      int scheduleId) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();

      final result = await conn.query(''' 
        select 
          fs.id, fs.nome_servico, fs.valor_servico, fs.fornecedor_id
        from agendamento_servicos as ags
        inner join fornecedor_servicos fs on fs.id = ags.fornecedor_servicos_id
        where ags.agendamento_id = ?
      ''', [scheduleId]);

      return result
          .map(
            (s) => ScheduleSupplierService(
              service: SupplierService(
                  id: s['id'],
                  name: s['nome_servico'],
                  price: s['valor_servico'],
                  supplierId: s['fornecedor_id']),
            ),
          )
          .toList();
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar os servicos de um agendamento', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<Schedule>> findAllSchedulesByUserSupplier(int userId) async {
     MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final query = '''
        select 
          a.id,
          a.data_agendamento,
          a.status,
          a.nome,
          a.nome_pet,
          f.id as fornec_id,
          f.nome as fornec_nome,
          f.logo
        from agendamento as a
          inner join fornecedor f on f.id = a.fornecedor_id
          inner join usuario u on u.fornecedor_id = f.id
        where u.id = ?
        order by a.data_agendamento desc
      ''';

      final result = await conn.query(query, [userId]);

      final scheduleResultFuture = result
          .map(
            (s) async => Schedule(
              id: s['id'],
              scheduleDate: s['data_agendamento'],
              status: s['status'],
              name: s['nome'],
              petName: s['nome_pet'],
              userId: userId,
              supplier: Supplier(
                id: s['fornec_id'],
                logo: (s['logo'] as Blob?).toString(),
                name: s['fornec_nome'],
              ),
              services: await findAllServicesBySchedule(s['id']),
            ),
          )
          .toList();

      return Future.wait(scheduleResultFuture);
    } on MySqlException catch (e, s) {
      log.error('Erro buscar agendamentos de um usuário', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }
}
