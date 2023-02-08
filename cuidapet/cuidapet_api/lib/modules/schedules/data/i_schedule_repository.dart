import 'package:cuidapet_api/entities/schedule.dart';

abstract class IScheduleRepository {

  Future<void> save(Schedule schedule);
  Future<void> changeStatus(String status, int scheduleId);
  Future<List<Schedule>> findAllSchedulesByUser(int userId);
  Future<List<Schedule>> findAllSchedulesByUserSupplier(int userId);
}