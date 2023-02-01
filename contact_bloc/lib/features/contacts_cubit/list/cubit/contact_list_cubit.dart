import 'dart:developer';

import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repository/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_list_cubit_state.dart';

part 'contact_list_cubit.freezed.dart';

class ContactListCubit extends Cubit<ContactListCubitState> {
  final ContactsRepository _repository;

  ContactListCubit({required ContactsRepository repository})
      : _repository = repository,
        super(ContactListCubitState.initial());

  Future<void> findAll() async {
    try {
      emit(ContactListCubitState.loading());
      final contacts = await _repository.findAll();
      await Future.delayed(const Duration(seconds: 1));
      emit(ContactListCubitState.data(contacts: contacts));
    } catch (e, s) {
      log('Erro ao buscar contatos', error: e, stackTrace: s);
      emit(ContactListCubitState.error(error: 'Erro ao buscar contatos'));
    }
  }

   Future<void> deleteByModel(ContactModel model) async {
    emit(ContactListCubitState.loading());
    await _repository.delete(model);
    findAll();
  }
}
