import 'package:flutter/material.dart';

class Detalhe2Page extends StatelessWidget {

  const Detalhe2Page({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Detalhe '),),
           body: Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop('Parametro retornado pela tela Detalhe2Page');
              },
              child: const Text('Voltar')),
           ),
       );
  }
}