import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/contact_update_cubit.dart';

class ContactUpdateCubitPage extends StatefulWidget {
  final ContactModel contact;

  const ContactUpdateCubitPage({Key? key, required this.contact})
      : super(key: key);

  @override
  State<ContactUpdateCubitPage> createState() => _ContactUpdateCubitPageState();
}

class _ContactUpdateCubitPageState extends State<ContactUpdateCubitPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEC;
  late final TextEditingController _emailEC;

  @override
  void initState() {
    super.initState();
    _nameEC = TextEditingController(text: widget.contact.name);
    _emailEC = TextEditingController(text: widget.contact.email);
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _nameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Update Cubit'),
      ),
      body: BlocListener<ContactUpdateCubit, ContactUpdateCubitState>(
        listener: (context, state) {
          state.whenOrNull(
              success: () => Navigator.of(context).pop(),
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle:
                        const TextStyle(fontSize: 15, color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.deepPurpleAccent.shade400)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blue.shade800)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null) {
                      return 'Nome é Obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _emailEC,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle:
                        const TextStyle(fontSize: 15, color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blue.shade300)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blue.shade600)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null) {
                      return 'E-mail é Obrigatório';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    final validate = _formKey.currentState?.validate() ?? false;
                    if (validate) {
                      context.read<ContactUpdateCubit>().save(
                          widget.contact.id!, _nameEC.text, _emailEC.text);
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactUpdateCubit, ContactUpdateCubitState>(
                  selector: (state) {
                    return state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
