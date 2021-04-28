import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

import '../Model/AboutUsModel.dart';
import 'apiService.dart';

part 'about_us_service.g.dart';

class AboutUsService = _AboutUsServiceBase with _$AboutUsService;

abstract class _AboutUsServiceBase with Store {
  static var client = http.Client();

  @observable
  List<Location> aboutUsShopInformation = [];

  @observable
  List<Aboutus> aboutUsGeneralInformation = [];

  @observable
  AboutUsState aboutUsState = AboutUsState.NORMAL;

  @action
  Future getAboutUsInformation() async {
    aboutUsState = AboutUsState.LOADING;
    var route = {
      'route': 'api/customapis/staticContens',
      'api_token': ServiceHelper.shared.apiKey,
    };

    var urlPath = Uri.https(ServiceHelper.url, '', route);

    final response = await client.get(urlPath);

    if (response.statusCode == 200) {
      var data = response.body;
      var jsonData = aboutUsModelFromJson(data);
      aboutUsState = AboutUsState.SUCCESS;
      aboutUsGeneralInformation = jsonData.aboutus;
      aboutUsShopInformation = jsonData.location;
    } else {
      aboutUsState = AboutUsState.ERROR;
      throw Exception('Blog Gönderileri Getirilirken Hata Meydana Geldi');
    }
  }
}

enum AboutUsState { LOADING, NORMAL, SUCCESS, ERROR }
