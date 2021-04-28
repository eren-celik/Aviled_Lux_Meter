import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  AboutUsModel({
    this.location,
    this.aboutus,
  });

  List<Location> location;
  List<Aboutus> aboutus;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        location: List<Location>.from(json['location'].map((x) => Location.fromJson(x))),
        aboutus: List<Aboutus>.from(json['aboutus'].map((x) => Aboutus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'location': List<dynamic>.from(location.map((x) => x.toJson())),
        'aboutus': List<dynamic>.from(aboutus.map((x) => x.toJson())),
      };
}

class Aboutus {
  Aboutus({
    this.content,
    this.image,
    this.logo,
  });

  String content;
  String image;
  String logo;

  factory Aboutus.fromJson(Map<String, dynamic> json) => Aboutus(
        content: json['content'],
        image: json['image'],
        logo: json['logo'],
      );

  Map<String, dynamic> toJson() => {
        'content': content,
        'image': image,
        'logo': logo,
      };
}

class Location {
  Location({
    this.title,
    this.phone,
    this.email,
    this.workinghours,
    this.adress,
    this.town,
    this.city,
  });

  String title;
  String phone;
  String email;
  Workinghours workinghours;
  String adress;
  String town;
  String city;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        title: json['title'],
        phone: json['phone'],
        email: json['email'],
        workinghours: Workinghours.fromJson(json['workinghours']),
        adress: json['adress'],
        town: json['town'],
        city: json['city'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'phone': phone,
        'email': email,
        'workinghours': workinghours.toJson(),
        'adress': adress,
        'town': town,
        'city': city,
      };
}

class Workinghours {
  Workinghours({
    this.weekDays,
    this.saturday,
    this.sunday,
  });

  String weekDays;
  String saturday;
  String sunday;

  factory Workinghours.fromJson(Map<String, dynamic> json) => Workinghours(
        weekDays: json['weekDays'],
        saturday: json['saturday'],
        sunday: json['sunday'],
      );

  Map<String, dynamic> toJson() => {
        'weekDays': weekDays,
        'saturday': saturday,
        'sunday': sunday,
      };
}
