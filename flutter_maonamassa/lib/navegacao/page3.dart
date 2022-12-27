import 'package:flutter/material.dart';

import 'page4.dart';

class Page3 extends StatelessWidget {

  const Page3({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Pagina 3'),),
           body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      settings: const RouteSettings(name: 'page4' ) ,
                      builder: (context) => const Page4()
                    )
                  );
                },
                child: const Text('Page 4 Via Page'),
              ),
               ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Pop'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Page 3 Via Named'),
              ),
            ]),
          ),
       );
  }
}