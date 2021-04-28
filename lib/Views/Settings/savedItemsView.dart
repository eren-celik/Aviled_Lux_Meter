import 'package:aviled_light_sensor/Extension/customViews.dart';
import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatelessWidget {
  static const myData = [
    ["A", "✔"],
    ["B", "❓"],
    ["C", "✖"],
    ["D", "❓"],
    ["E", "✖"],
    ["F", "✖"],
    ["G", "✔"],
  ];

  const SavedItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kaydedilenler',
      ),
      body: Center(
          child: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: LineChart(
          lines: [
            Line(
              stroke: PaintOptions.stroke(color: Colors.green, strokeWidth: 2),
              marker: MarkerOptions(paint: PaintOptions.fill(color: Colors.red), size: 4),
              data: myData,
              xFn: (datum) => datum[0],
              yFn: (datum) => datum[1],
            ),
          ],
        ),
      )),
    );
  }
}
