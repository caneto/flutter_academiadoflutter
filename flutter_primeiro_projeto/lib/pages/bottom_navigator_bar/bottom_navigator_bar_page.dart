import 'package:flutter/material.dart';

import 'page1.dart';
import 'page2.dart';

class BottomNavigatorBarPage extends StatefulWidget {

  const BottomNavigatorBarPage({ Key? key }) : super(key: key);

  @override
  State<BottomNavigatorBarPage> createState() => _BottomNavigatorBarPageState();
}

class _BottomNavigatorBarPageState extends State<BottomNavigatorBarPage> {

   int indice = 0;

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Bottom Navigator Bar'),),
           bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            currentIndex: indice,
            onTap: (index) {
              setState(() {
                indice = index;
              });
            },
            items: const [
               BottomNavigationBarItem(
                label: 'Pagina 1',
                icon: Icon(Icons.add_a_photo_outlined)
               ),
               BottomNavigationBarItem(
                label: 'Pagina 2',
                icon: Icon(Icons.delete_forever_outlined)
               ) 
            ]
           ),
           body: IndexedStack(
            index: indice,
            children: const [
              Page1(),
              Page2(),
            ],
           ),
       );
  }
}