part of 'contact_register_bloc.dart';

@freezed
class ContactRegisterState with _$ContactRegisterState {
  const factory ContactRegisterState.initial() = _initial;
  const factory ContactRegisterState.loading() = _loading;
  const factory ContactRegisterState.success() = _success;
  const factory ContactRegisterState.error({required String message}) = _error;
}

