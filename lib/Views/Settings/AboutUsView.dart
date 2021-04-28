import '../../Core/Theme.dart';
import '../../Service/about_us_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class AboutUsView extends StatefulWidget {
  @override
  _AboutUsViewState createState() => _AboutUsViewState();

  static void navigateTo() async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(40.98489365874764, 37.88153392680939),
      title: 'Aviled',
      description: 'Aviled Ordu Mağzası',
    );
  }
}

class _AboutUsViewState extends State<AboutUsView> {
  AboutUsService aboutUsService = AboutUsService();
  String version = '';

  Future<String> platformInfo() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var buildNumber = packageInfo.buildNumber;
    return '$version+($buildNumber)';
  }

  @override
  void initState() {
    super.initState();
    aboutUsService.getAboutUsInformation();
    platformInfo().then((value) {
      setState(() {
        version = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notify, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0,
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: notify.darkTheme ? Colors.white : Colors.black),
            title: Text(
              'Hakkımızda',
              style: TextStyle(color: notify.darkTheme ? Colors.white : Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  AboutUsView.navigateTo();
                },
                icon: Icon(
                  CupertinoIcons.paperplane,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          body: Center(
            child: Observer(builder: (_) {
              switch (aboutUsService.aboutUsState) {
                case AboutUsState.LOADING:
                  return CupertinoActivityIndicator();
                  break;
                case AboutUsState.NORMAL:
                  return CupertinoActivityIndicator();
                  break;
                case AboutUsState.SUCCESS:
                  return AboutUsBody(aboutUsService: aboutUsService, version: version);
                  break;
                case AboutUsState.ERROR:
                  return Text('Hata Meydana Geldi');
                  break;
              }
              return Text('Veri Bulunamadı');
            }),
          ),
        );
      },
    );
  }
}

class AboutUsBody extends StatelessWidget {
  const AboutUsBody({
    @required this.aboutUsService,
    @required this.version,
  });

  final AboutUsService aboutUsService;
  final String version;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(aboutUsService.aboutUsGeneralInformation.first.image),
            Html(
              data: aboutUsService.aboutUsGeneralInformation.first.content,
            ),
            Column(
              children: aboutUsService.aboutUsShopInformation.map(
                (data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      SizedBox(height: 15),
                      ListTile(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoActionSheet(
                                title: const Text('Ara'),
                                actions: <Widget>[
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      launch('tel://${data.phone}');
                                      Navigator.pop(context, 'One');
                                    },
                                    child: Text(data.phone),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  child: const Text('Geri'),
                                ),
                              );
                            },
                          );
                        },
                        leading: Icon(
                          Icons.phone,
                        ),
                        title: Text(data.phone),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.map_fill,
                        ),
                        title: Text('${data.adress} \n${data.town} / ${data.city}'),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.mail,
                        ),
                        title: Text(data.email),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.clock_fill),
                        title: Text(
                          'Pazartesi - Cumartesi : ${data.workinghours.weekDays}\nCumartesi : ${data.workinghours.saturday}\nPazar: ${data.workinghours.sunday}',
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
            Divider(),
            Image.network(aboutUsService.aboutUsGeneralInformation.first.logo),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                'Version $version',
              ),
            )
          ],
        ),
      ),
    );
  }
}
