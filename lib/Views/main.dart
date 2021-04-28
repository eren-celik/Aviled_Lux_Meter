import 'dart:async';

import 'package:light/light.dart';

import '../Service/about_us_service.dart';
import '../Service/apiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Core/Theme.dart';
import 'Settings/settingsView.dart';
import 'homeView.dart';
import 'package:oscilloscope/oscilloscope.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AboutUsService>(
          create: (context) => AboutUsService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
            return MaterialApp(
              title: '',
              theme: notifier.darkTheme ? dark : light,
              home: HomeNavigation(),
            );
          },
        ),
      ),
    );
  }
}

class HomeNavigation extends StatefulWidget {
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  ApiService apiService = ApiService();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    apiService.apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      //body: Shell(),
      body: _selectedIndex == 0 ? HomePage() : Settings(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house),
          activeIcon: Icon(CupertinoIcons.house_fill),
          label: 'Ana Sayfa',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.gear),
          activeIcon: Icon(CupertinoIcons.gear_alt_fill),
          label: 'Ayarlar',
          backgroundColor: Colors.white,
        ),
      ],
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class Shell extends StatefulWidget {
  @override
  _ShellState createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  Light _light;
  String _luxString = '?';
  List<double> traceX = [];
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
      _subscription = _light.lightSensorStream.listen((event) {
        setState(() {
          traceX.add(event.toDouble());
        });
      });
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
    // Create A Scope Display
    Oscilloscope scopeOne = Oscilloscope(
      backgroundColor: Colors.black,
      traceColor: Colors.green,
      yAxisMax: 10.0,
      yAxisMin: -10.0,
      dataSet: traceX,
    );

    // Generate the Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(_luxString),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: scopeOne),
        ],
      ),
    );
  }
}
