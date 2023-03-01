import 'package:asuka/asuka.dart';

class Messages {
  const Messages._();

  static void alert(String message) => AsukaSnackbar.alert(message).show();

  static void info(String message) => AsukaSnackbar.info(message).show();

  static void success(String message) => AsukaSnackbar.success(message).show();
}
