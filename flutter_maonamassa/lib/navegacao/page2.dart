import 'package:flutter/material.dart';

import 'page3.dart';

class Page2 extends StatelessWidget {
  
  static final String routeName = '/page2';
  const Page2({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Pagina 2'),),
           body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      settings: const RouteSettings(name: 'page3' ) ,
                      builder: (context) => const Page3()
                    )
                  );
                },
                child: const Text('Page 3 Via Page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Pop'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/page3');
                },
                child: const Text('Page 3 Via Named'),
              ),
            ]),
          ),
       );
  }
}