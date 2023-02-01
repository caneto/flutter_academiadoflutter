import 'package:mobx/mobx.dart';
part 'future_controller.g.dart';

class FutureController = FutureControllerBase with _$FutureController;

abstract class FutureControllerBase with Store {
  @observable
  var nomeFuture = ObservableFuture.value("value");
  // var nomeFuture = Future.value("").asObservable();

  @action
  Future<void> buscarNome() async {
    final buscaNomeFuture =
        Future.delayed(const Duration(seconds: 2), () => "Eduardo Muniz");
    // nomeFuture = buscaNomeFuture.asObservable();
    nomeFuture = ObservableFuture(buscaNomeFuture);
  }
}
