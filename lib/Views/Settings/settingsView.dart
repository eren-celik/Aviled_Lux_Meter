import '../../Core/Theme.dart';
import '../../Extension/customViews.dart';
import '../../app_localization.dart';
import 'AboutUsView.dart';
import 'savedItemsView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).translate('ayarlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AboutUsView(),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.orange.shade100,
                    child: Icon(
                      CupertinoIcons.question,
                      size: 20,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).translate('hakkimizda'),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.35),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SavedItems(),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red.shade100,
                    child: Icon(
                      CupertinoIcons.bookmark_fill,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).translate('kaydedilenler'),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.deepPurple.shade100,
                  child: Icon(
                    CupertinoIcons.moon_fill,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                ),
                Text(
                  AppLocalizations.of(context).translate('karanlıkmod'),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) {
                    return CupertinoSwitch(
                      value: notifier.darkTheme,
                      onChanged: (val) {
                        notifier.toogleTheme();
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
