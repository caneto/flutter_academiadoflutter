import 'package:flutter/material.dart';

class MaterialBannerPage extends StatelessWidget {
  const MaterialBannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Banner'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final materialbanner = MaterialBanner(
                    content: const Text('Teste de Material Banner'),
                    forceActionsBelow: true,
                    backgroundColor: Colors.blue,
                    actions: [
                      TextButton(
                        onPressed: (){
                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                        }, 
                        child: const Text('Cancelar'))
                    ],
                  );

                  ScaffoldMessenger.of(context).showMaterialBanner(materialbanner);
                },
                child: const Text('Simple Material Banner'),
              ),
            ]),
      ),
    );
  }
}
