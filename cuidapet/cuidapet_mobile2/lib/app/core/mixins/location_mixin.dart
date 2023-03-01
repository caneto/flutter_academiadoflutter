import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

mixin LocationMixin<E extends StatefulWidget> on State<E> {
  void showDialogLocationServiceUnavailable() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Precisamos da sua localização'),
          content: const Text(
            'Para realizar a busca da sua localização, precisamos que você permita o uso do seu GPS.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Geolocator.openLocationSettings();
              },
              child: const Text('Abrir configurações'),
            ),
          ],
        ),
      );

  void showDialogLocationDenied({VoidCallback? tryAgain}) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Precisamos da sua autorização'),
          content: const Text(
            'Para realizar a busca da sua localização, precisamos que você autorize o uso do seu GPS.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (tryAgain != null) {
                  tryAgain();
                }
              },
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );

  void showDialogLocationDeniedForever() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Precisamos da sua autorização'),
          content: const Text(
            'Para realizar a busca da sua localização, precisamos que você autorize a utilização. '
            'Clique em "Abrir configurações" para abrir o menu de configurações do aplicativo.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Geolocator.openAppSettings();
              },
              child: const Text('Abrir configurações'),
            ),
          ],
        ),
      );
}
