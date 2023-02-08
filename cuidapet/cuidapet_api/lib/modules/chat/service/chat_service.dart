import 'package:cuidapet_api/application/facades/push_notification_facade.dart';
import 'package:cuidapet_api/entities/chat.dart';
import 'package:cuidapet_api/modules/chat/view_models/chat_notify_view_model.dart';
import 'package:injectable/injectable.dart';

import 'package:cuidapet_api/modules/chat/data/i_chat_repository.dart';

import './i_chat_service.dart';

@LazySingleton(as: IChatService)
class ChatService implements IChatService {
  final IChatRepository repository;
  final PushNotificationFacade pushNotificationFacade;

  ChatService({
    required this.repository,
    required this.pushNotificationFacade,
  });

  @override
  Future<int> startChat(int scheduleId) => repository.startChat(scheduleId);

  @override
  Future<void> notifyChat(ChatNotifyViewModel model) async {
    final chat = await repository.findChatById(model.chat);

    if (chat != null) {
      switch (model.notificationUserType) {
        case NotificationUserType.user:
          _notifyUser(chat.userDeviceToken?.tokens, model, chat);
          break;
        case NotificationUserType.supplier:
          _notifyUser(chat.supplierDeviceToken?.tokens, model, chat);
          break;
        default:
          throw Exception('Tipo de notificação não encontrada');
      }
    }
  }

  void _notifyUser(
      List<String?>? tokens, ChatNotifyViewModel model, Chat chat) {
    final payload = <String, dynamic>{
      'type': 'CHAT_MESSAGE',
      'chat': {
        'id': chat.id,
        'name': chat.name,
        'user': chat.user,
        'supplier': {
          'id': chat.supplier.id,
          'name': chat.supplier.name,
          'logo': chat.supplier.logo,
        }
      }
    };

    pushNotificationFacade.sendMessage(
      devices: tokens ?? [],
      title: 'Nova Mensagem',
      body: model.message,
      payload: payload,
    );
  }

  @override
  Future<List<Chat>> getChatsByUser(int user) =>
      repository.getChatsByUser(user);

  @override
  Future<List<Chat>> getChatsBySupplier(int supplier) =>
      repository.getChatsBySupplier(supplier);

  @override
  Future<void> endChat(int chatId) => repository.endChat(chatId);
}
