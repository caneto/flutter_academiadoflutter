import 'package:cuidapet_api/entities/schedule.dart';
import 'package:cuidapet_api/modules/schedules/view_models/schedule_save_input_model.dart';

abstract class IScheduleService {
  Future<void> scheduleService(ScheduleSaveInputModel model);
  Future<void> changeStatus(String status, int scheduleId);
  Future<List<Schedule>> findAllSchedulesByUser(int userId);
  Future<List<Schedule>> findAllSchedulesByUserSupplier(int userId);
}