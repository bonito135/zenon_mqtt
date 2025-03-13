import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends StatefulWidget {
  const RadialGauge({super.key});

  @override
  State<RadialGauge> createState() => _RadialGaugeState();
}

class _RadialGaugeState extends State<RadialGauge> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 150,
          ranges: <GaugeRange>[
            GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
            GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
            GaugeRange(startValue: 100, endValue: 150, color: Colors.red),
          ],
          pointers: <GaugePointer>[NeedlePointer(value: 90)],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                '90.0',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
