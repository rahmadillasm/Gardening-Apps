part of 'models.dart';

class Collection {
  int _id;
  String _name;
  String _category;
  String _place;
  String _notes;

  Collection(this._name, this._category, this._place, this._notes);

  Collection.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._category = map['category'];
    this._place = map['place'];
    this._notes = map['notes'];
  }

  //getter
  int get id => _id;
  // ignore: unnecessary_getters_setters
  String get name => _name;
  // ignore: unnecessary_getters_setters
  String get category => _category;
  // ignore: unnecessary_getters_setters
  String get place => _place;
  // ignore: unnecessary_getters_setters
  String get notes => _notes;

  //setter
  // ignore: unnecessary_getters_setters
  set name(String value) {
    _name = value;
  }

  // ignore: unnecessary_getters_setters
  set category(String value) {
    _category = value;
  }

  // ignore: unnecessary_getters_setters
  set place(String value) {
    _place = value;
  }

  // ignore: unnecessary_getters_setters
  set notes(String value) {
    _notes = value;
  }

  //konversi dari Collection ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['category'] = category;
    map['place'] = place;
    map['notes'] = notes;
    return map;
  }
}
