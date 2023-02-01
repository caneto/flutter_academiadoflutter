// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:developer' as developer;

import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repository/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_cubit_state.dart';

part 'contact_register_cubit.freezed.dart';

class ContactRegisterCubit extends Cubit<ContactRegisterCubitState> {
  final ContactsRepository _repository;

  ContactRegisterCubit({required ContactsRepository repository})
      : _repository = repository,
        super(const ContactRegisterCubitState.initial());

  FutureOr<void> save(
    String name,
    String email,    
  ) async {
    try {
      emit(const ContactRegisterCubitState.loading());

      await Future.delayed(const Duration(seconds: 2));

      final contactModel = ContactModel(
        name: name,
        email: email,
      );

      //throw Exception();
      await _repository.create(contactModel);
      emit(const ContactRegisterCubitState.success());
    } catch (e, s) {
      developer.log(
        'Erro ao salvar um novo usuário',
        error: e.toString(),
        stackTrace: s,
      );
      emit(const ContactRegisterCubitState.error(
          error: 'Erro ao salvar um novo contato'));
    }
  }
}
