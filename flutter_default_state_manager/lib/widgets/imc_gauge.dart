import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'imc_gouge_range.dart';

class ImcGauge extends StatelessWidget {

  final double imc;

  const ImcGauge({Key? key, required this.imc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
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
          pointers: [
            NeedlePointer(
              value: imc,
              enableAnimation: true,
            )
          ],
        )
      ],
    );
  }
}
