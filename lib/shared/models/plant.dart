part of 'models.dart';

class Plant {
  int _id;
  String _name;
  String _picture;
  String _category;
  String _description;
  String _water;
  String _temperatur;
  String _light;
  String _tips;

  Plant(this._name, this._picture, this._category, this._description, this._water,
      this._temperatur, this._light, this._tips);

  Plant.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._picture = map['picture'];
    this._category = map['category'];
    this._description = map['description'];
    this._water = map['water'];
    this._temperatur = map['temperatur'];
    this._light = map['light'];
    this._tips = map['tips'];
  }

  int get id => _id;
  // ignore: unnecessary_getters_setters
  String get name => _name;
  // ignore: unnecessary_getters_setters
  String get picture => _picture;
  // ignore: unnecessary_getters_setters
  String get category => _category;
  // ignore: unnecessary_getters_setters
  String get description => _description;
  // ignore: unnecessary_getters_setters
  String get water => _water;
  // ignore: unnecessary_getters_setters
  String get temperatur => _temperatur;
  // ignore: unnecessary_getters_setters
  String get light => _light;
  // ignore: unnecessary_getters_setters
  String get tips => _tips;

  // ignore: unnecessary_getters_setters
  set name(String value) {
    _name = value;
  }
  // ignore: unnecessary_getters_setters
  set picture(String value) {
    _picture = value;
  }
  // ignore: unnecessary_getters_setters
  set category(String value) {
    _category = value;
  }
  // ignore: unnecessary_getters_setters
  set description(String value) {
    _description = value;
  }
  // ignore: unnecessary_getters_setters
  set water(String value) {
    _water = value;
  }
  // ignore: unnecessary_getters_setters
  set temperatur(String value) {
    _temperatur = value;
  }
  // ignore: unnecessary_getters_setters
  set light(String value) {
    _light = value;
  }
  // ignore: unnecessary_getters_setters
  set tips(String value) {
    _tips = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['picture'] = picture;
    map['category'] = category;
    map['description'] = description;
    map['water'] = water;
    map['temperatur'] = temperatur;
    map['light'] = light;
    map['tips'] = tips;
    return map;
  }
}
