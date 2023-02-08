import 'dart:async';
import 'dart:convert';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/modules/chat/service/i_chat_service.dart';
import 'package:cuidapet_api/modules/chat/view_models/chat_notify_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'chat_controller.g.dart';

@Injectable()
class ChatController {
  final IChatService service;
  final ILogger log;

  ChatController({
    required this.service,
    required this.log,
  });

  // /chats/schedule/1/start-chat
  @Route.post('/schedule/<scheduleId>/start-chat')
  Future<Response> startChatByScheduleId(
      Request request, String scheduleId) async {
    try {
      final chatId = await service.startChat(int.parse(scheduleId));

      return Response.ok(jsonEncode({'chat_id': chatId}));
    } catch (e, s) {
      log.error('Erro ao iniciar chat', e, s);
      return Response.internalServerError();
    }
  }

  @Route.post('/notify')
  Future<Response> notifyUser(Request request) async {
    try {
      final model = ChatNotifyViewModel(await request.readAsString());
      await service.notifyChat(model);
      return Response.ok(jsonEncode({}));
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode(
          {'message': 'Erro ao enviar notificação'},
        ),
      );
    }
  }

  @Route.get('/user')
  Future<Response> findChatsByUser(Request request) async {
    try {
      final user = int.parse(request.headers['user']!);
      final chats = await service.getChatsByUser(user);

      final resultChats = chats
          .map((c) => {
                'id': c.id,
                'user': c.user,
                'name': c.name,
                'pet_name': c.petName,
                'supplier': {
                  'id': c.supplier.id,
                  'name': c.supplier.name,
                  'logo': c.supplier.logo
                }
              })
          .toList();

      return Response.ok(jsonEncode(resultChats));
    } catch (e, s) {
      log.error('Erro ao buscar chats do usuário', e, s);
      return Response.internalServerError();
    }
  }

  @Route.get('/supplier')
  Future<Response> findChatsBySupplier(Request request) async {
    final supplier = request.headers['supplier'];

    if (supplier == null) {
      return Response(400,
          body: jsonEncode({'message': 'Usuário logado não é um fornecedor'}));
    }

    final supplierId = int.parse(supplier);
    try {
      final chats = await service.getChatsBySupplier(supplierId);

      final resultChats = chats
          .map((c) => {
                'id': c.id,
                'user': c.user,
                'name': c.name,
                'pet_name': c.petName,
                'supplier': {
                  'id': c.supplier.id,
                  'name': c.supplier.name,
                  'logo': c.supplier.logo
                }
              })
          .toList();

      return Response.ok(jsonEncode(resultChats));
    } catch (e, s) {
      log.error('Erro ao buscar os chats do fornecedor $supplierId', e, s);
      return Response.internalServerError();
    }
  }

  @Route.put('/<chatId>/end-chat')
  Future<Response> endChat(Request request, String chatId) async {
    try {
      await service.endChat(int.parse(chatId));
      return Response.ok(jsonEncode({}));
    } catch (e, s) {
      log.error('Erro ao finalizar o chat $chatId', e, s);
      return Response.internalServerError();
    }
  }

  Router get router => _$ChatControllerRouter(this);
}
