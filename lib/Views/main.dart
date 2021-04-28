
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Core/Theme.dart';
import '../Service/about_us_service.dart';
import '../Service/apiService.dart';
import 'Settings/settingsView.dart';
import 'homeView.dart';

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
