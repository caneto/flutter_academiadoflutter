import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gouge_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcSetstatePage extends StatefulWidget {
  const ImcSetstatePage({Key? key}) : super(key: key);

  @override
  State<ImcSetstatePage> createState() => _ImcSetstatePageState();
}

class _ImcSetstatePageState extends State<ImcSetstatePage> {

  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc SetState'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SfRadialGauge(
              axes: [
                RadialAxis(
                  showLabels: false,
                  showAxisLine: false,
                  showTicks: false,
                  minimum: 12.5,
                  maximum: 47.9,
                  ranges: [
                    ImcGougeRange(
                      color: Colors.blue,
                      start: 12.5,
                      end: 18.5,
                      label: 'MAGREZA',
                    ),
                    ImcGougeRange(
                      color: Colors.green,
                      start: 18.5,
                      end: 24.5,
                      label: 'NORMAL',
                    ),
                    ImcGougeRange(
                      color: Colors.yellow[600]!,
                      start: 24.5,
                      end: 29.9,
                      label: 'SOBREPESSO',
                    ),
                    ImcGougeRange(
                      color: Colors.red[500]!,
                      start: 29.9,
                      end: 39.9,
                      label: 'OBSIDADE',
                    ),
                    ImcGougeRange(
                      color: Colors.red[900]!,
                      start: 39.9,
                      end: 47.9,
                      label: 'OBSIDADE GRAVE',
                    )
                  ],
                  pointers: const [
                    NeedlePointer(
                      value: 15,
                      enableAnimation: true,
                    )

                  ],
                )
              ],
            ),
            const SizedBox(
               height: 20,
            ),
            TextFormField(
              controller: pesoEC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Peso'),
              inputFormatters: [
                CurrencyTextInputFormatter(
                  locale: 'pt_BR',
                  symbol: '',
                  turnOffGrouping: true,
                  decimalDigits: 2
                )
              ],
            ),
             TextFormField(
              controller: alturaEC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Altura'),
              inputFormatters: [
                CurrencyTextInputFormatter(
                  locale: 'pt_BR',
                  symbol: '',
                  turnOffGrouping: true,
                  decimalDigits: 2
                )
              ],
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){}, child: const Text('Calcular IMC'))
          ]),
        ),
      ),
    );
  }
}
