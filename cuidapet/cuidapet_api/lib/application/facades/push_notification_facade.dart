import 'dart:convert';

import 'package:cuidapet_api/application/config/application_config.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton()
class PushNotificationFacade {
  final ILogger log;

  PushNotificationFacade({
    required this.log,
  });

  Future<void> sendMessage({
    required List<String?> devices,
    required String title,
    required String body,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final request = {
        'notification': {
          'body': body,
          'title': title,
        },
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          'payload': payload
        }
      };
      final env = GetIt.I.get<ApplicationConfig>().env;

      final firebaseKey = env['FIREBASE_PUSH_KEY'] ?? env['firebasePushKey'];
      if(firebaseKey == null) {
        return;
      }
      
      for (var device in devices) {
        if (device != null) {
          request['to'] = device;
          log.info('Enviando mensagem para: $device');
          final result = await http.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(request),
            headers: {
              'Authorization': 'key=$firebaseKey',
              'Content-Type': 'application/json'
            }
          );
      
          final responseData = jsonDecode(result.body);
      
          if(responseData['failure'] == 1) {
            log.error('Erro ao enviar notification $device erro: ${responseData['results']?[0]}');
          }else{
            log.info('Notificação enviada com sucesso $device');
          }
        }
      }
    } catch (e, s) {
      log.error('Erro ao enviar notificação', e, s);
    }
  }
}
