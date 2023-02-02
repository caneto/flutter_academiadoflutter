import 'package:cuidapet_api/controllers/agendamento/dto/agendar_servico_rq.dart';
import 'package:cuidapet_api/core/constants.dart';
import 'package:cuidapet_api/models/usuario_model.dart';
import 'package:cuidapet_api/repositories/agendamento_repository.dart';
import 'package:cuidapet_api/repositories/chat_repository.dart';
import 'package:cuidapet_api/repositories/fornecedores_repository.dart';
import 'package:cuidapet_api/utils/push_notification_helper.dart';
import 'package:dio/dio.dart' as dio;

import '../../cuidapet_api.dart';

class AgendamentoController extends ResourceController {
  final _repository = AgendamentoRepository();
  final _chatRepository = ChatRepository();

  @Operation.post()
  Future<Response> agendarServico(@Bind.body() AgendarServicoRQ agendaServicoRq) async {
    final UsuarioModel user = request.attachments['user'] as UsuarioModel;
    await _repository.agendar(user.id, agendaServicoRq);
    return Response.ok({});
  }

  @Operation.get()
  Future<Response> buscarAgendamentos() async {
    final user = request.attachments['user'] as UsuarioModel;
    final agendamentos = await _repository.buscarTodosAgendamentos(user.id);
    return Response.ok(agendamentos.map((a) => a.toMap()).toList());
  }

  Future<Response> buscarAgendamentoDoFornecedor(UsuarioModel user) async {
    final agendamentos = await _repository.buscarTodosAgendamentosFornecedor(user.fornecedorId);
    return Response.ok(agendamentos.map((a) => a.toMap()).toList());
  }

  Future<void> alteraStatus(int agenda, String status) async {
    await _repository.alterarStatus(agenda, status);
    final tokens = await _repository.getTokenUsuarioMensagem(agenda);
    final payload = {'type': 'AU'};
    await PushNotificationHelper.sendMessage(
      [tokens['ios'], tokens['android']],
      "Agendamento Atualizado",
      "Agendamento atualizado para ${statusAgendamento(status)}",
      payload,
    );
  }

  Future<void> iniciarChat(int agenda) async {
    final chat = await _chatRepository.iniciarChat(agenda);
    final aparelhosUsuario = await _chatRepository.recuperarDeviceIdPorChat(chat, 'U');
    final chatDados = await _chatRepository.recuperarPorId(chat);
    await PushNotificationHelper.sendMessage(aparelhosUsuario, "Sobre seu agendamento", 'O Pet Gostaria de falar com você', {'type': 'CHAT_MESSAGE', 'chat': chatDados.toMap()});
  }
}
