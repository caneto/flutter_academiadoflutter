import 'package:flutter/material.dart';

class HomePageStatefull extends StatefulWidget {

  const HomePageStatefull({ Key? key }) : super(key: key);

  @override
  State<HomePageStatefull> createState() => _HomePageStatefullState();
}

class _HomePageStatefullState extends State<HomePageStatefull> {

  String texto = "Estou no StatefullWidget";

  @override
  void initState() {
    super.initState();
    texto = "Texto alterado pelo initState";
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(title: const Text("Texto"),) ,
      body: Column(children: [
        Text(texto),
        TextButton(
          onPressed: () {
            setState(() {
              texto = 'Alterei o texto do StateFullWidget';  
            });
          },
          child: const Text('Alterar Texto'),
        )
      ]),
    );
  }
}