import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  const HomePage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
          appBar: AppBar(
            title: const Text("Nossa primeira AppBar"),  
            backgroundColor: Colors.green,
            actions: [
              IconButton(icon: const Icon(Icons.add_a_photo_outlined), onPressed: () {  },)
            ],
          ),
          drawer: const Drawer(
            child: Center(child: Text('Nossa drawer aberto'),),
          ),
          endDrawer: const Drawer(
            child: Center(child: Text('Drawer end'),),
          ),
          body: const Center(child: Text('Nossa Primeira Pagina'))
       );
  }
}