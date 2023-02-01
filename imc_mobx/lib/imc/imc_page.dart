import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import 'imc_controller.dart';
import 'widgets/imc_gaude.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final _controller = ImcController();
  final _pesoEC = TextEditingController();
  final _alturaEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final reactionDisposers = <ReactionDisposer>[];
  @override
  void initState() {
    super.initState();

    final reactionError = reaction<bool>(
      (_) => _controller.hasError,
      (hasError) {
        if (hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(_controller.error ?? "Erro!!")));
        }
      },
    );
    reactionDisposers.add(reactionError);
  }

  @override
  void dispose() {
    super.dispose();
    _alturaEC.dispose();
    _pesoEC.dispose();
    for (var reactionDisposers in reactionDisposers) {
      reactionDisposers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular Imc MobX'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Observer(
                  builder: (_) {
                    return ImcGauge(imc: _controller.imc);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura",
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
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: "pt_BR",
                      symbol: "",
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    )
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Altura obrigatória";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso",
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
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: "pt_BR",
                      symbol: "",
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    )
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Peso obrigatório";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.amber),
                    onPressed: () {
                      var formValid =
                          _formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        var formater = NumberFormat.simpleCurrency(
                            locale: "pt_BR", decimalDigits: 2);
                        double peso = formater.parse(_pesoEC.text) as double;
                        double altura =
                            formater.parse(_alturaEC.text) as double;
                        _controller.calcularImc(peso: peso, altura: altura);
                      }
                    },
                    child: const Text("Calcular Imc")),
                const SizedBox(height: 20),
                const Text("Example test MobX"),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 15,
                  spacing: 20,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            backgroundColor: Colors.blue.shade400),
                        onPressed: () =>
                            Navigator.of(context).pushNamed("/observableList"),
                        child: const Text("Observable List")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            backgroundColor: Colors.blue.shade400),
                        onPressed: () =>
                            Navigator.of(context).pushNamed("/modelObservable"),
                        child: const Text("Model Observable")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            backgroundColor: Colors.blue.shade400),
                        onPressed: () =>
                            Navigator.of(context).pushNamed("/contador"),
                        child: const Text("contador")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            backgroundColor: Colors.blue.shade400),
                        onPressed: () =>
                            Navigator.of(context).pushNamed("/contadorCodegen"),
                        child: const Text("Contador CodeGen")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
