import 'package:sqflite/sqlite_api.dart';

abstract class Migration {
  void create(Batch batch);
  void upgrade(Batch batch);
}