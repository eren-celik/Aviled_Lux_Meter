import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Core/Theme.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Size preferredSize;
  CustomAppBar({Key key, this.title}) : preferredSize = Size.fromHeight(50.0);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notify, child) {
        return AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: notify.darkTheme ? Colors.white : Colors.black),
          actions: [],
          title: Text(title ?? ''),
        );
      },
    );
  }
}
