
import 'package:mocktail/mocktail.dart';
import 'package:mysql1/mysql1.dart';

class MockMysqlConnection extends Mock implements MySqlConnection {
  MockMysqlConnection() {
    when(() => close()).thenAnswer((_) async => _);
  }
}