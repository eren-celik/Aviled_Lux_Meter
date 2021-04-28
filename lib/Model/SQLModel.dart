class DataModel {
  int id;
  String name;
  String luxValue;
  String date;

  DataModel(
    this.id,
    this.name,
    this.luxValue,
    this.date,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name ': name,
      'luxValue': luxValue,
      'date': date,
    };
  }

  DataModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    luxValue = map["luxValue"];
    date = map['date'];
  }
}
