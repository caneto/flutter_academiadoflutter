import 'package:bloc_test/bloc_test.dart';
import 'package:contact_bloc/features/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repository/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
  late ContactsRepository repository;
  late ContactListCubit cubit;
  late List<ContactModel> contacts;

  //preparação
  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactListCubit(repository: repository);
    contacts = [
      const ContactModel(
          name: 'Carlos Alberto Pinto', email: "caneto@gmail.com"),
      const ContactModel(name: 'Cristiane', email: "cris@cris.com"),
    ];
  });

   blocTest<ContactListCubit, ContactListCubitState>(
    'Deve Buscar os Contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp:  () {
      when(() => repository.findAll(),).thenAnswer((_) async => contacts);
    },
    expect: () => [
      const ContactListCubitState.loading(),
      ContactListCubitState.data(contacts: contacts),
    ],
  );

  blocTest<ContactListCubit, ContactListCubitState>(
    'Deve retornar erro ao Buscar contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    expect: () => [
      const ContactListCubitState.loading(),
      const ContactListCubitState.error(error: 'Erro ao buscar contatos'),
    ],
  );
}