
import 'package:cuidapet_api/controllers/chat/dto/notificarUsuario.dart';
import 'package:cuidapet_api/models/usuario_model.dart';
import 'package:cuidapet_api/repositories/chat_repository.dart';
import 'package:cuidapet_api/utils/push_notification_helper.dart';

import '../../cuidapet_api.dart';

class ChatController extends ResourceController {
  
  final _chatRepository = ChatRepository();

  @Operation.get()
  Future<Response> buscarChatsUsuario() async {
    final user = request.attachments['user'] as UsuarioModel;
    final chats = await _chatRepository.buscarChatsUsuario(user.id);
    return Response.ok(chats
        .map((a) => {
              'id': a.id,
              'usuario': a.usuario,
              'nome': a.nome,
              'nome_pet': a.nomePet,
              'fornecedor': {'id': a.fornecedor.id, 'nome': a.fornecedor.nome, 'logo': a.fornecedor.logo}
            })
        .toList());
  }

  @Operation.put('id')
  Future<Response> closeChat(@Bind.path('id') int id) async {
    await _chatRepository.closeChat(id);
    return Response.ok({});
  }

  @Operation.post()
  Future<Response> notificarUsuario(@Bind.body() NotificarUsuarioRequest request) async {
    final List<String> aparelhos = await _chatRepository.recuperarDeviceIdPorChat(request.chat, request.para);
    final chat = await _chatRepository.recuperarPorId(request.chat);
    await PushNotificationHelper.sendMessage(aparelhos, "Nova Mensagem", request.mensagem, {'type': 'CHAT_MESSAGE', 'chat': chat.toMap()});
    return Response.ok({});
  }


}