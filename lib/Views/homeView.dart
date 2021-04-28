import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Extension/customViews.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Light _light;
  String _luxString = '?';
  StreamSubscription _subscription;

  void onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatFormState();
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
  }

  Future<void> initPlatFormState() async {
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    double nivel = double.tryParse('$_luxString') ?? 123;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularPercentIndicator(
                  radius: 250.0,
                  lineWidth: 10.0,
                  percent: (nivel <= 999) ? nivel / 1000 : 0.0,
                  center: Center(
                    child: Text(
                      "$_luxString",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.yellowAccent,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Lux Değeri : ($_luxString)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
            ),
            TextButton(
              onPressed: () => print('object'),
              child: Text('Kaydet'),
            )
          ],
        ),
      ),
    );
  }
}
