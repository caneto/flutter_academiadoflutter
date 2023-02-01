part of 'contact_register_cubit.dart';

@freezed
class ContactRegisterCubitState with _$ContactRegisterCubitState {
  const factory ContactRegisterCubitState.initial() = _Initial;
  const factory ContactRegisterCubitState.loading() = _Loading;
  const factory ContactRegisterCubitState.data(
      {required List<ContactModel> contacts}) = _Data;
  const factory ContactRegisterCubitState.save() = _Save;
  const factory ContactRegisterCubitState.error({required String error}) =
      _Error;
  const factory ContactRegisterCubitState.success() = _Sucess;
}
