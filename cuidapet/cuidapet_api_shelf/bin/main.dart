import 'package:cuidapet_api/cuidapet_api.dart';

Future main() async {
  final app = Application<CuidapetApiChannel>()
      ..options.configurationFilePath = "config.yaml"
      ..options.port = 8888
      ..options.address = '0.0.0.0';

  final count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}