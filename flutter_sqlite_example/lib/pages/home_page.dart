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
    DatabaseSqLite().openConnection();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Home Page'),),
           body: Container(),
       );
  }
}