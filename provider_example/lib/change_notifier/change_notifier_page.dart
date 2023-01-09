import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_exemple/change_notifier/provider_controller.dart';
import 'package:tuple/tuple.dart';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 1));
      context.read<ProviderController>().alterarDados();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build Page ChangeNotifierPage');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Consumer<ProviderController>(
              Selector<ProviderController, String>(  
                selector: (_, controller) => controller.imgAvatar,
                builder: (_, imgAvatar, __) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(imgAvatar),
                    radius: 40,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Selector<ProviderController, String>(
                    selector: (_, controller) => controller.name,
                    builder: (_, name, __) {
                      return Text(name);
                    },
                  ),
                  Selector<ProviderController, String>(
                    selector: (_, controller) => controller.birthDate,
                    builder: (_, birthDate, __) {
                      return Text('(${birthDate})');
                    },
                  ),
                ],
              ),
              Selector<ProviderController, Tuple2<String, String>>(
                selector: (_, controller) => Tuple2(controller.birthDate, controller.name),
                builder: (_, tuple, __) {
                  return Text('${tuple.item2} (${tuple.item1})');
                },
              ),
              ElevatedButton(onPressed: (){
                context.read<ProviderController>().alterarNome();
              }, 
              child: Text('Alterar Nome'))
            ],
          ),
        ),
      ),
    );
  }
}
