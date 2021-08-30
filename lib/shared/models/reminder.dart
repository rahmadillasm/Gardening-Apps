part of 'models.dart';

class Reminder {
  int id;
  String name;
  // int howManyWeeks;
  // String category;
  int time;
  int notifyId;

  Reminder(
      {this.id,
      this.name,
      // this.howManyWeeks,
      // this.category,
      this.time,
      this.notifyId});

  Map<String, dynamic> reminderToMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['name'] = this.name;
    // map['howManyWeeks'] = this.howManyWeeks;
    // map['category'] = this.category;
    map['time'] = this.time;
    map['notifyId'] = this.notifyId;
    return map;
  }

  Reminder reminderMapToObject(Map<String, dynamic> reminderMap) {
    return Reminder(
      id: reminderMap['id'],
      name: reminderMap['name'],
      // howManyWeeks: reminderMap['howManyWeeks'],
      // category: reminderMap['category'],
      time: reminderMap['time'],
      notifyId: reminderMap['notifyId']
    );
  }

  // String get image{
  //   switch(this.category){
  //     case "Tanaman Hias": return "assets/images/hias_kembang_sepatu.jpg"; break;
  //     case "Tanaman Obat": return "assets/images/obat_kencur.jpg"; break;
  //     case "Tanaman Sayuran": return "assets/images/sayur_mentimun.jpg"; break;
  //   }
  // }
}
