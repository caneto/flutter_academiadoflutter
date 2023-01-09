import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseSqLite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXAMPLE');

    return await openDatabase(
      databaseFinalPath,
      version: 1,
      onConfigure: (db) async {
        print('onConfigure sendo chamado');
      },
      // Chamado somente no momento de criação do banco de dados
      // primera vez que carrega o aplicativo
      onCreate: (Database db, int version) {
        print('onCreate Chamado');
        final batch = db.batch();

        batch.execute('''
          create table teste(
            id Integer primary key autoincrement,
            nome varchar(200),
          )
        ''');
        batch.execute('''
            create table produto(
              id Integer primary key autoincrement,
              nome varchar(200),
            )
          ''');
      //  batch.execute('''
      //      create table produto(
      //        id Integer primary key autoincrement,
      //        nome varchar(200),
      //      )
      //    ''');
        batch.commit();
      },
      // Será chamado sempre que ouver uma alteração no version incremental (1->2)
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        print('onUpgrade Chamado');  
        final batch = db.batch();

        if(oldVersion == 1) {
          batch.execute('''
            create table produto(
              id Integer primary key autoincrement,
              nome varchar(200),
            )
          ''');
        //  batch.execute('''
        //    create table categoria(
        //      id Integer primary key autoincrement,
        //      nome varchar(200),
        //    )
        //  ''');
        }

       // if(oldVersion == 3) {
       //   batch.execute('''
       //     create table categoria(
       //       id Integer primary key autoincrement,
       //       nome varchar(200),
       //     )
       //   ''');
       // }

        batch.commit();
      },
      // Será chamado sempre que ouver uma alteração na version decremental (2->1)
      onDowngrade: (Database db, int oldVersion, int newVersion) {
        print('onDowngrade Chamado');
        final batch = db.batch();

        if(oldVersion == 3) {
          batch.execute('''
            drop table categoria
          ''');
        }


        batch.commit();
        
      }
    );

    return openConnection();
  }
}
