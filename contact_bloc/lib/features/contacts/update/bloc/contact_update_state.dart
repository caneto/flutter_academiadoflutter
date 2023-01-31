part of 'contact_update_bloc.dart';

@freezed
class ContactUpdateState with _$ContactUpdateState {
  const factory ContactUpdateState.initial() = _Initial;
  const factory ContactUpdateState.loading() = _Loading;
  const factory ContactUpdateState.error({required String message}) = _Error;
  const factory ContactUpdateState.success() = _Sucess;
}
