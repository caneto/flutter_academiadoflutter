// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'imc_gauge_range.dart';

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
          minimum: 12.5,
          maximum: 47.9,
          ranges: [
            ImcGaugeRange(
                color: Colors.blue, start: 12.5, end: 18.5, label: "MAGREZA"),
            ImcGaugeRange(
                color: Colors.green, start: 18.5, end: 24.5, label: "NORMAL"),
            ImcGaugeRange(
                color: Colors.yellow,
                start: 24.5,
                end: 29.9,
                label: "SOBREPESO"),
            ImcGaugeRange(
                color: Colors.orange,
                start: 29.9,
                end: 39.9,
                label: "OBESIDADE"),
            ImcGaugeRange(
                color: Colors.red,
                start: 39.9,
                end: 47.9,
                label: "OBESIDADE GRAVE"),
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
