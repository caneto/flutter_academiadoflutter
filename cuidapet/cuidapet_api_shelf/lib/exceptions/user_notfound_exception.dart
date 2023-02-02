import 'package:mysql1/mysql1.dart';

class UserNotFoundException implements Exception {

  UserNotFoundException({this.message});

  String message;

}
