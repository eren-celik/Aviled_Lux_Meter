import 'dart:async';

import '../app_localization.dart';

import '../Model/SQLModel.dart';
import '../Service/DatabaseService.dart';
import 'Settings/savedItemsView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Extension/customViews.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Light _light;
  String _luxString = 'unknown';
  String locationName = '';
  StreamSubscription _subscription;

  DatabaseHelper databaseHelper = DatabaseHelper();
  DateTime now = DateTime.now();
  List<double> traceX = [];

  void onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
      traceX.add(luxValue.toDouble());
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (_) {}
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
    Oscilloscope scopeTwo = Oscilloscope(
      showYAxis: true,
      margin: EdgeInsets.all(10.0),
      strokeWidth: 3.0,
      backgroundColor: Colors.black,
      traceColor: Colors.white,
      yAxisMax: 2.0,
      yAxisMin: -1.0,
      dataSet: traceX,
    );

    double nivel = double.tryParse('$_luxString') ?? 0.0;
    DateTime date = new DateTime(now.day, now.month, now.year);
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
                  percent: (nivel <= 4000) ? nivel / 4000 : 0.0,
                  center: Center(
                    child: Text(
                      "$_luxString",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.green,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${AppLocalizations.of(context).translate('lüxdegeri')} : ($_luxString)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              AppLocalizations.of(context).translate('selectplace'),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  TextField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: AppLocalizations.of(context).translate('entervalue'),
                                    ),
                                    onChanged: (value) {
                                      locationName = value;
                                    },
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  AppLocalizations.of(context).translate('tamam'),
                                ),
                              ),
                            ],
                          );
                        },
                      ).then((value) {
                        if (locationName != '') {
                          databaseHelper
                              .insertData(DataModel(DateTime.now().millisecondsSinceEpoch.remainder(100000), locationName, _luxString, "$date"))
                              .then((value) => showSnackBarVoid(context, AppLocalizations.of(context).translate('kaydedildi'), Icons.thumb_up));
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.save),
                        ),
                        Text(
                          AppLocalizations.of(context).translate('kaydet'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: scopeTwo),
          ],
        ),
      ),
    );
  }
}
