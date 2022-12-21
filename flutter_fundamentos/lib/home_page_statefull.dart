import 'package:flutter/material.dart';
import 'package:flutter_fundamentos/home_page.dart';

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
    texto = "Texto alterado pelo";
    //Future.delayed(const Duration(seconds: 1), () {
    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeStateLessPage()));  
    //});

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('addPostFrameCallBack'); 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeStateLessPage()));  
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

   @override
   Widget build(BuildContext context) {
      print('builld');
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(texto),
              TextButton(
                onPressed: () {
                  setState(() {
                    texto = 'Alterei o texto do StateFullWidget';  
                  });
                },
                child: const Text('Alterar Texto'),
              )
            ]
          ),
        ),
      );
  }
}