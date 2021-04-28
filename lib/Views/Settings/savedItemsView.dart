import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Extension/customViews.dart';
import '../../Model/SQLModel.dart';
import '../../Service/DatabaseService.dart';

class SavedItems extends StatefulWidget {
  @override
  _SavedItemsState createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kaydedilenler',
      ),
      body: Center(
        child: FutureBuilder(
          future: databaseHelper.getData(),
          builder: (context, AsyncSnapshot<List<DataModel>> snapshot) {
            if (!snapshot.hasData) return CupertinoActivityIndicator();
            if (snapshot.data.isEmpty) return Text('Veri Bulunamadı');
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final data = snapshot.data[index];
                final date = DateTime.parse(data.date);
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(),
                        Icon(
                          CupertinoIcons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) => databaseHelper.removeData(data.id).then((value) {
                    setState(() {
                      snapshot.data.remove(index);
                    });
                    showSnackBarVoid(context, 'Başarıyla Silindi', CupertinoIcons.hand_thumbsup);
                  }),
                  child: ListTile(
                    title: Text(data.name),
                    subtitle: Text('Tarih: ${date.day}-${date.month}-${date.year} / ${date.hour}: ${date.minute}'),
                    trailing: Text('Lüx: ${data.luxValue}'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void showSnackBarVoid(BuildContext context, String message, IconData icon, [GlobalKey<ScaffoldState> globalKey]) async {
  if (globalKey != null) {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 500),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 20),
          Expanded(
            child: Text('$message'),
          )
        ],
      ),
    );
    ScaffoldMessenger.of(globalKey.currentContext).showSnackBar(snackBar);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 20),
            Expanded(
              child: Text('$message'),
            )
          ],
        ),
      ),
    );
  }
}
