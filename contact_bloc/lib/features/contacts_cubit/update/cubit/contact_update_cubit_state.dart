part of 'contact_update_cubit.dart';

@freezed
class ContactUpdateCubitState with _$ContactUpdateCubitState {
  const factory ContactUpdateCubitState.initial() = _Initial;
  const factory ContactUpdateCubitState.loading() = _Loading;
  const factory ContactUpdateCubitState.save() = _Save;
  const factory ContactUpdateCubitState.error({required String error}) =
      _Error;
  const factory ContactUpdateCubitState.success() = _Sucess;
}
