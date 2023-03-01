import 'package:flutter_modular/flutter_modular.dart';

import 'schedules_page.dart';

class SchedulesModule extends Module {

   @override
   final List<Bind> binds = [];

   @override
   final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const SchedulesPage())
   ];

}
