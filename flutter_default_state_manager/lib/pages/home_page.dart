import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/setState/imc_setstate_page.dart';

import '../value_notifier/value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _goToPage(context, const ImcSetstatePage()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shadowColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
            ),
            child: const Text('SetState'),
          ),
          ElevatedButton(
            onPressed: () => _goToPage(context, const ValueNotifierPage()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shadowColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
            ),
            child: const Text('ValueNotifier'),
          ),
          ElevatedButton(
            onPressed: () {
              //Navigator.of(context).popAndPushNamed('/desafio');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shadowColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
            ),
            child: const Text('ChangeNotifier'),
          ),
          ElevatedButton(
            onPressed: () {
              //Navigator.of(context).popAndPushNamed('/desafio');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shadowColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
            ),
            child: const Text('Bloc Pattern (Streams)'),
          ),
        ],
      )),
    );
  }
}
