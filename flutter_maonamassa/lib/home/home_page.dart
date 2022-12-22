import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  const HomePage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
          appBar: AppBar(
            title: const Text("HomePage"),  
            backgroundColor: Colors.green,
          ),
          body: Center(
            child: Container(
              width: 200,
              height: 200,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    offset: Offset(2,2),
                  ),
                  BoxShadow(
                    color: Colors.amberAccent,
                    blurRadius: 20,
                    offset: Offset(-2,-2),
                  )
                ]
              ),
              child: Text('Nossa Primeira Pagina')
            )
          )
       );
  }
}