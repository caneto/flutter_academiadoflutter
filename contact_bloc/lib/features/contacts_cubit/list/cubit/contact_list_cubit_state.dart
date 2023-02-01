part of 'contact_list_cubit.dart';

@freezed
class ContactListCubitState with _$ContactListCubitState {
  const factory ContactListCubitState.initial() = _Initial;
  const factory ContactListCubitState.loading() = _Loading;
  const factory ContactListCubitState.data({required List<ContactModel> contacts}) =
      _Data;
  const factory ContactListCubitState.error({required String error}) = _Error;
}

