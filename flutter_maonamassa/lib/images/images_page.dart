import 'package:flutter/material.dart';

class ImagesPage extends StatelessWidget {

  const ImagesPage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       print(MediaQuery.of(context).devicePixelRatio);
       return Scaffold(
           appBar: AppBar(
              title: const Text('Imagens'),
           ),
           body: Center(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                        image: AssetImage('assets/paissagem.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    child: const Text('Paissagem', 
                                      style: TextStyle(
                                        backgroundColor: Colors.white),
                                  )
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.amber,
                    child: Image.network(
                      'http://capsistema.com.br/wp-content/uploads/2022/08/flutter_logo.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )),
       );
  }
}