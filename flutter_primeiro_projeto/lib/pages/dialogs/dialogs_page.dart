import 'package:flutter/material.dart';
import 'package:flutter_primeiro_projeto/pages/dialogs/dialog_custom.dart';

class DialogsPage extends StatelessWidget {
  const DialogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialogs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return DialogCustom(context);
                      });
                },
                child: const Text('Dialog')),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text('Simple Dialog'),
                          contentPadding: const EdgeInsets.all(10),
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Titulo x'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Fechar Dialog'),
                            )
                          ],
                        );
                      });
                },
                child: const Text('SimpleDialog')),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Alert Dialog'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Deseja realmente salvar??'),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Confirmar'),
                            )
                          ],
                        );
                      });
                },
                child: const Text('Alert Dialog')),
            ElevatedButton(
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  print("O horario selecionado foi $selectedTime");
                },
                child: const Text('Time Picker')),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2018),
                  lastDate: DateTime(2025),
                );
                print('A data selecionada $selectedDate');
              },
              child: const Text('Date Picker'),
            ),
            ElevatedButton(
              onPressed: () async {
                showAboutDialog(context: context, applicationIcon: Icon(Icons.flutter_dash));
              },
              child: const Text('About Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
