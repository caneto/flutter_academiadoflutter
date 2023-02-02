import 'package:dio/dio.dart';

class PushNotificationHelper {
  static Future<void> sendMessage(List<String> devices, String title, String body, Map<String, dynamic> payload) async {
    final header = BaseOptions(headers: {'Authorization': 'key=AAAAQ3zv4FI:APA91bFzltkHZzFm0mSUa65EmImvKZePTjPuLOPOHQEEeEKShepw4Q5RDjQVQYVf-cHhi2y_OcDwqSp5RVaedzYJ3HfmvJj6-UU-oZ6ebNuWqCX7V2IfGegpseY3BoMBUDipIBzj_IzY'});
    final request = {
      "notification": {"body": body, "title": title},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        'payload': payload,
      },
    };

    for (var device in devices) {
      if (device != null) {
        request['to'] = device;
        var res = await Dio(header).post('https://fcm.googleapis.com/fcm/send', data: request);
        print(res.data);
      }
    }

  }
}
