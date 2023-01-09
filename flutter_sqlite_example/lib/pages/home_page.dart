import 'package:flutter/material.dart';
import 'package:flutter_sqlite_exemple/database/database_sqlite.dart';

class HomePage extends StatefulWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _dataBase();
  }

  Future<void> _dataBase() async {
    final database = await DatabaseSqLite().openConnection();

    //database.insert('teste', {'nome': 'Carlos Alberto'});
    //database.delete('teste', where: 'nome = ?', whereArgs: ['Carlos Alberto']);
    //database.update('teste', {'nome': 'Curso de Fluter'}, where: 'nome = ?', whereArgs: ['Carlos Alberto']);

    //var result = await database.query('teste');
    //print(result);

    //database.rawInsert('insert into teste values(null, ?)', ['Carlos Alberto']);
    //database.rawUpdate('update teste set nome = ? where id = ?', ['Curso de Flutter', 1]);
    //database.rawDelete('delete from teste from id = ?', [1]);

    var result = await database.rawQuery('select * from teste');
    print(result);


  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Home Page'),),
           body: Container(),
       );
  }
}