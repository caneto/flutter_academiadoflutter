// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:developer' as developer;

import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repository/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_cubit_state.dart';

part 'contact_update_cubit.freezed.dart';

class ContactUpdateCubit extends Cubit<ContactUpdateCubitState> {
  final ContactsRepository _repository;

  ContactUpdateCubit({required ContactsRepository repository})
      : _repository = repository,
        super(const ContactUpdateCubitState.initial());

  FutureOr<void> save(
    String id,
    String name,
    String email,    
  ) async {
    try {
      emit(const ContactUpdateCubitState.loading());

      await Future.delayed(const Duration(seconds: 2));

      final model = ContactModel(
        id: id,
        name: name,
        email: email,
      );

      //throw Exception();
      await _repository.update(model);
      emit(const ContactUpdateCubitState.success());
    } catch (e, s) {
      developer.log(
        'Erro ao atualizar o usuário',
        error: e.toString(),
        stackTrace: s,
      );
      emit(const ContactUpdateCubitState.error(
          error: 'Erro ao atualizar o contato'));
    }
  }
}
