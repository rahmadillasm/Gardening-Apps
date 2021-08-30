part of 'helpers.dart';

class SqfliteHelper {
  static Database _database;

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "MyDatabase.db");
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Reminder (
            id INTEGER PRIMARY KEY, 
            name TEXT, 
            time INTEGER, 
            notifyId INTEGER)''');
      await db.execute('''
          CREATE TABLE collection(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            category TEXT,
            place TEXT,
            notes TEXT
          )''');
    });
    return database;
  }

//init
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

//select
  Future<List<Map<String, dynamic>>> selectCollection() async {
    Database db = await this.database;
    var mapList = await db.query('collection', orderBy: 'name');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectReminder(table) async {
    Database db = await database;
    try {
      return db.query('Reminder');
    } catch (e) {
      return null;
    }
  }

//insert
  Future<int> insertCollection(Collection object) async {
    Database db = await this.database;
    int count = await db.insert('collection', object.toMap());
    return count;
  }

  Future<int> insertReminder(String table, Map<String, dynamic> data) async {
    Database db = await database;
    try {
      return await db.insert('Reminder', data);
    } catch (e) {
      return null;
    }
  }

//delete
  Future<int> deleteCollection(int id) async {
    Database db = await this.database;
    int count = await db.delete('collection', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<int> deleteReminder(String table, int id) async {
    Database db = await database;
    try {
      return await db.delete('Reminder', where: 'id=?', whereArgs: [id]);
    } catch (e) {
      return null;
    }
  }

//update
  Future<int> updateCollection(Collection object) async {
    Database db = await this.database;
    int count = await db.update('collection', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<List<Collection>> getCollectionList() async {
    var collectionMapList = await selectCollection();
    int count = collectionMapList.length;
    // ignore: deprecated_member_use
    List<Collection> collectionList = List<Collection>();
    for (int i = 0; i < count; i++) {
      collectionList.add(Collection.fromMap(collectionMapList[i]));
    }
    return collectionList;
  }

  Future<List<Plant>> getPlantListFromJsonFile(BuildContext context) async {
    // var collectionMapList = await select();
    // int count = collectionMapList.length;
    // ignore: deprecated_member_use
    List<Plant> plant = List<Plant>();
    // for (int i = 0; i < count; i++) {
    //   collectionList.add(Collection.fromMap(collectionMapList[i]));
    // }
    // String rawJson = '{"id":1,"name":"Mary","category":"aaa","place":"sss"}';

    // Map<String, dynamic> map = jsonDecode(rawJson);
    // collectionList.add(Collection.fromMap(map));

    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/plant_list.json");

    var jsonData = json.decode(data);
    for (Map i in jsonData) {
      plant.add(Plant.fromMap(i));
    }
    // jsonData.forEach((item) {
    //   item.forEach((key, value) {
    //     collectionList
    //         .add(Collection.fromMap(value));
    //   });
    // });
    return plant;
  }
}
