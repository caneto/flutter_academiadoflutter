import 'dart:async';
import 'dart:convert';

import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:cuidapet_api/modules/schedules/service/i_schedule_service.dart';
import 'package:cuidapet_api/modules/schedules/view_models/schedule_save_input_model.dart';

part 'schedule_controller.g.dart';

@Injectable()
class ScheduleController {
  final IScheduleService service;
  final ILogger log;

  ScheduleController({
    required this.service,
    required this.log,
  });

  @Route.post('/')
  Future<Response> scheduleServices(Request request) async {
    try {
      final userId = int.parse(request.headers['user']!);
      final inputModel = ScheduleSaveInputModel(
          userId: userId, dataRequest: await request.readAsString());
      await service.scheduleService(inputModel);
      return Response.ok(jsonEncode({}));
    } catch (e, s) {
      log.error('Erro ao salvar agendamento', e, s);
      return Response.internalServerError();
    }
  }

  // /schedules/1/status/C
  @Route.put('/<scheduleId|[0-9]+>/status/<status>')
  Future<Response> changeStatus(
      Request request, String scheduleId, String status) async {
    try {
      await service.changeStatus(status, int.parse(scheduleId));
      return Response.ok(jsonEncode({}));
    } catch (e, s) {
      log.error('Erro ao alterar status do agendamento', e, s);
      return Response.internalServerError();
    }
  }

  @Route.get('/')
  Future<Response> findAllSchedulesByUser(Request request) async {
    final userId = int.parse(request.headers['user']!);
    try {
      final result = await service.findAllSchedulesByUser(userId);

      final response = result
          .map(
            (s) => {
              'id': s.id,
              'schedule_date': s.scheduleDate.toIso8601String(),
              'status': s.status,
              'name': s.name,
              'pet_name': s.petName,
              'supplier': {
                'id': s.supplier.id,
                'name': s.supplier.name,
                'logo': s.supplier.logo
              },
              'services': s.services
                  .map((e) => {
                        'id': e.service.id,
                        'name': e.service.name,
                        'price': e.service.price
                      })
                  .toList(),
            },
          )
          .toList();

      return Response.ok(jsonEncode(response));
    } catch (e, s) {
      log.error('Erro ao buscar agendamentos do usuário [$userId]', e, s);
      return Response.internalServerError();
    }
  }


  @Route.get('/supplier')
  Future<Response> findAllSchedulesBySupplier(Request request) async {
    final userId = int.parse(request.headers['user']!);
    try {
      final result = await service.findAllSchedulesByUserSupplier(userId);

      final response = result
          .map(
            (s) => {
              'id': s.id,
              'schedule_date': s.scheduleDate.toIso8601String(),
              'status': s.status,
              'name': s.name,
              'pet_name': s.petName,
              'supplier': {
                'id': s.supplier.id,
                'name': s.supplier.name,
                'logo': s.supplier.logo
              },
              'services': s.services
                  .map((e) => {
                        'id': e.service.id,
                        'name': e.service.name,
                        'price': e.service.price
                      })
                  .toList(),
            },
          )
          .toList();

      return Response.ok(jsonEncode(response));
    } catch (e, s) {
      log.error('Erro ao buscar agendamentos do usuário fornecedor [$userId]', e, s);
      return Response.internalServerError();
    }
  }

  Router get router => _$ScheduleControllerRouter(this);
}
