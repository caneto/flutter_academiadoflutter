import 'package:contact_bloc/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactUpdatePage extends StatefulWidget {
  final ContactModel contactModel;
  
  const ContactUpdatePage({Key? key, required this.contactModel}) : super(key: key);

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameEC;
  late final TextEditingController emailEC;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Update'),
      ),
      body: Container(),
    );
  }
}
