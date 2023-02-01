// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          direction: Axis.horizontal,
          //spacing: 20,
          //runSpacing: 100,
          children: <Widget>[
            _ButtonCard(
              textOption: 'Exemple',
              onTap: () { 
                Navigator.of(context).pushNamed('/bloc/example/');
              },
            ),
            _ButtonCard(
              textOption: 'Exemple Frezed',
              onTap: () {                 
                Navigator.of(context).pushNamed('/bloc/example/freezed');
              },
            ),
            _ButtonCard(
              textOption: 'Contact',
              onTap: () {                 
                Navigator.of(context).pushNamed('/contacts/list');
              },
            ),
            _ButtonCard(
              textOption: 'Contact Cubit',
              onTap: () {                 
                Navigator.of(context).pushNamed('/contacts/cubit/list');
              },
            ),
          ],
        ),
      ),
    );
  }

  _ButtonCard({required String textOption, VoidCallback? onTap}) {

    return Container(
      padding: const EdgeInsets.all(2.0),
      width: 180,
      height: 180,
      child: Center(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: onTap,
              child: Card(
                elevation: 3,
                shadowColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.deepPurpleAccent
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.grey[100],
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          textOption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
