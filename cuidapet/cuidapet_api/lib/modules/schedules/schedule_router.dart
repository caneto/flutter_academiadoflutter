import 'package:cuidapet_api/application/routers/i_router.dart';
import 'package:cuidapet_api/modules/schedules/controller/schedule_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

class ScheduleRouter implements IRouter {
  @override
  void configure(Router router) {
    final scheduleController = GetIt.I.get<ScheduleController>();
    router.mount('/schedules/', scheduleController.router);
  }
}
