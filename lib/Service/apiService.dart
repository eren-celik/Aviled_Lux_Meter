import '../Model/ApiModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService with ChangeNotifier {
  static String _url = 'aviled.com.tr';
  static var client = http.Client();

  Future apiCall() async {
    final route = {
      'route': 'api/login',
    };

    final bodyData = {
      'username': 'android',
      'key':
          'zgV0cIJ8gkpNoM5ojgUCydSyj43UCFk06JnyCjTlLjRMDVmxkfDRoSiQbKvV4nm18RamSHOkWNL120oFzLq4x4b3o7m2f6Q4Nw0t1Q3Sp20Jr4C2XU0dtswcNvtL0dpacAHBobfjm25FuAMR27vjLIdVn3NdaVzaCWOiwdtHsiNZJvfMLAUoOuF5OFV5WwyeEUeL5oQQV4Y1JpapOxKwP8P64nHOvihOShr3jYygRnpfJBrvInztooPgPggNhNHz',
    };

    var urlPath = Uri.https(
      _url,
      '',
      route,
    );

    final response = await client.post(
      urlPath,
      body: bodyData,
    );

    if (response.statusCode == 200) {
      try {
        var decodedJson = response.body;
        var jsonModel = apiTokenFromJson(decodedJson);
        ServiceHelper.shared.apiKey = jsonModel.apiToken;
      } catch (e, _) {}
    } else {
      throw Exception(
        'Api Servisinde HataMeydan Geldi Getirilirken Hata Meydana Geldi ',
      );
    }
  }
}

class ServiceHelper {
  static final ServiceHelper shared = ServiceHelper._internal();
  ServiceHelper._internal();

  static const url = 'aviled.com.tr';
  var apiKey = '';

  factory ServiceHelper() {
    return shared;
  }
}
