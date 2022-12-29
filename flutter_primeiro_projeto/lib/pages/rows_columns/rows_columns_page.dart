import 'package:flutter/material.dart';

class RowsColumnsPage extends StatelessWidget {

  const RowsColumnsPage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Rows & Columns'),),
           body: Container(
            color: Colors.red,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.blue,
                  child: const Text("Elemento 1"),
                ),
                const Text("Elemento 1"),
                const Text("Elemento 1"),
                Container(
                  height: 200,
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('1'),
                      Text('2'),
                      Text('3'),
                    ],
                  ),
                )
              ]
              ),
           ),
       );
  }
}