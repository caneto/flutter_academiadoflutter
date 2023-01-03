import 'package:flutter/material.dart';

class StackPage extends StatelessWidget {

  const StackPage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Stack'),),
           body: Stack(
            children: [
              Container(
                color: Colors.green,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  color: Colors.blue,
                  width: 300,
                  height: 300,
                ),
              ),
              //Align(
              //  alignment: Alignment.bottomRight,
              //  child: Container(
              //    color: Colors.pink,
              //    width: 150,
              //    height: 150,
              //  ),
              //),
              Positioned(
                //top:40,
                right: 100,
                bottom: 10,
                child: Container(
                  color: Colors.pink,
                  width: 150,
                  height: 150,
                ),
              )
           ]
         ),
       );
  }
}