import 'dart:async';
import 'dart:developer' as developer;

import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repository/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';

part 'contact_list_bloc.freezed.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactsRepository _repository;

  ContactListBloc({required ContactsRepository repository})
      : _repository = repository,
        super(ContactListState.initial()) {
    on<_ContactListEventFindAll>(_findAll);
    on<_ContactListEventDelete>(_delete);
  }

  Future<void> _findAll(
      _ContactListEventFindAll event, Emitter<ContactListState> emit) async {
    try {
      emit(ContactListState.loading());
      final contacts = await _repository.findAll();
      await Future.delayed(const Duration(seconds: 1));
      //throw Exception();
      emit(ContactListState.data(contacts: contacts));
    } catch (e, s) {
      developer.log(
        'Erro ao buscar contatos',
        error: e.toString(),
        stackTrace: s,
      );
      emit(ContactListState.error(error: 'Erro ao buscar contatos'));
    }
  }

  FutureOr<void> _delete(
    _ContactListEventDelete event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListState.loading());
    await _repository.delete(event.model);
    add(const ContactListEvent.findAll());
  }
}
