import 'package:contact_bloc/code/widgets/button_card.dart';
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
            ButtonCard(
              textOption: 'Exemple',
              onTap: () => Navigator.of(context).pushNamed('/bloc/example/'),
            ),
            ButtonCard(
              textOption: 'Exemple Frezed',
              onTap: () => Navigator.of(context).pushNamed('/bloc/example/freezed'),
            ),
            ButtonCard(
              textOption: 'Contact',
              onTap: () => Navigator.of(context).pushNamed('/contacts/list'),
            ),
            ButtonCard(
              textOption: 'Contact Cubit',
              onTap: () => Navigator.of(context).pushNamed('/contacts/cubit/list'),
            ),
          ],
        ),
      ),
    );
  }

  
}
