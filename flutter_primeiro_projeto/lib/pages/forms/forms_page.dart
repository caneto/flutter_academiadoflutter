import 'package:flutter/material.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({Key? key}) : super(key: key);

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  //String texto = '';

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final passEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    passEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              //TextField(
              //  onChanged: (String value) {
              //    setState(() {
              //      texto = value;
              //    });
              //  },
              //),
              //const SizedBox(
              //   height: 10,
              //),
              //Text('Texto digitado $texto'),
      
              TextFormField(
                controller: nameEC,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red)
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54
                  ),
                  isDense: true
                ),
                validator: (String? value) {
                  if(value == null || value.isEmpty) {
                    return 'Campo X não preenchido';
                  }
                },
              ),
              const SizedBox(
                 height: 10,
              ),
               TextFormField(
                controller: passEC,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red)
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54
                  ),
                  isDense: true,
                ),
                obscureText: true,
                validator: (String? value) {
                  if(value == null || value.isEmpty) {
                    return 'Campo X não preenchido';
                  }
                },
              ),

              const SizedBox(
                 height: 12,
              ),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(
                    value: "Item1",
                    child: Text('Item 1')
                  ),
                  DropdownMenuItem(
                    value: "Item2",
                    child: Text('Item 2')
                  ),
                  DropdownMenuItem(
                    value: "Item3",
                    child: Text('Item 3')
                  ),
                  DropdownMenuItem(
                    value: "Item4",
                    child: Text('Item 4')
                  ),
                ], 
                onChanged: (String? newValue){
                  return;
                },
                validator: (String? value) {
                  if(value == null || value.isEmpty) {
                    return 'Item não preenchido';
                   } 
                },
                value: 'Item2',
                elevation: 16,
                decoration: InputDecoration(
                  labelText: 'Item\'s',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue)
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red)
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54
                  ),
                ),
              ),
      
              ElevatedButton(
                  onPressed: () {
                    var formValid = formKey.currentState?.validate() ?? false;
                    var message = 'Formulário Inválido';
                    if (formValid) {
                       message = 'Formulário Válido (Name: ${nameEC.text})';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                    );
                  },
                  child: const Text('Salvar'))
            ]),
          ),
        ),
      ),
    );
  }
}
