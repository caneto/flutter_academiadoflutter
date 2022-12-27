import 'package:flutter/material.dart';

class DetalhePage extends StatelessWidget {

  const DetalhePage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       var parametro = ModalRoute.of(context)?.settings.arguments as String?;
       return Scaffold(
           appBar: AppBar(title: const Text('Detalhe'),),
           body: Center(
            child: Text(parametro ?? 'Não foi enviado o parametro'),
          ),
       );
  }
}