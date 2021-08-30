part of 'pages.dart';

void main() => runApp(CollectionPage());

class CollectionPage extends StatefulWidget {
  @override
  CollectionPageState createState() => CollectionPageState();
}

class CollectionPageState extends State<CollectionPage> {
  SqfliteHelper sqfliteHelper = SqfliteHelper();
  int count = 0;
  List<Collection> collectionList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (collectionList == null) {
      // ignore: deprecated_member_use
      collectionList = List<Collection>();
    }
    return Scaffold(
      body: createListView(),
      floatingActionButton: Align(
        alignment: Alignment(1, 0.8),
        child: FloatingActionButton(
          backgroundColor: mainColor,
          heroTag: "btnAdd1",
          child: Icon(Icons.add),
          tooltip: 'Tambah Data',
          onPressed: () async {
            var collection = await navigateToCollectionForm(context, null);
            if (collection != null) addCollection(collection);
          },
        ),
      ),
    );
  }

  Future<Collection> navigateToCollectionForm(
      BuildContext context, Collection collection) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return CollectionFormPage(collection);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   mainAxisSpacing: 10,
      // ),
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            var collection = await navigateToCollectionForm(
                context, this.collectionList[index]);
            if (collection != null) editCollection(collection);
          },
          child: Card(
            color: accentColor2,
            elevation: 0,
            margin: EdgeInsets.only(
              top: (index == 0) ? 15 : 0,
              bottom: (index == collectionList.length - 1) ? 80 : 10,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: ListTile(
              isThreeLine: true,
              title: Text(
                this.collectionList[index].name,
                style: darkGreenTextFont.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this.collectionList[index].category,
                      style: darkGreenTextFont.copyWith(fontSize: 14)),
                  Text(this.collectionList[index].place,
                      style: darkGreenTextFont.copyWith(fontSize: 14)),
                ],
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: accentColor1,
                ),
                onTap: () {
                  deleteCollection(collectionList[index]);
                },
              ),
              // leading: CircleAvatar(
              //   radius: 25,
              //   backgroundImage: AssetImage("assets/images/red_velvet_2.jpg"),
              // ),
            ),
          ),
        );
      },
    );
  }

//buat koleksi
  void addCollection(Collection object) async {
    int result = await sqfliteHelper.insertCollection(object);
    if (result > 0) {
      updateListView();
    }
  }

//edit koleksi
  void editCollection(Collection object) async {
    int result = await sqfliteHelper.updateCollection(object);
    if (result > 0) {
      updateListView();
    }
  }

//delete koleksi
  void deleteCollection(Collection object) async {
    int result = await sqfliteHelper.deleteCollection(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  // void deleteCollection(
  //     BuildContext context, String collectionName, int collectionId) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text("Hapus ?"),
  //             content:
  //                 Text("Apakah anda yakin ingin menghapus $collectionName ?"),
  //             contentTextStyle:
  //                 TextStyle(fontSize: 17, color: Colors.grey[800]),
  //             actions: [
  //               // ignore: deprecated_member_use
  //               FlatButton(
  //                 splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text(
  //                   "Cancel",
  //                   style: darkGreenTextFont,
  //                 ),
  //               ),
  //               // ignore: deprecated_member_use
  //               FlatButton(
  //                 splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
  //                 onPressed: () async {
  //                   int result =
  //                       await sqfliteHelper.deleteCollection(collectionId);
  //                   if (result > 0) {
  //                     updateListView();
  //                   }
  //                 },
  //                 child: Text(
  //                   "Cancel",
  //                   style: darkGreenTextFont,
  //                 ),
  //               )
  //             ],
  //           ));
  // }

//update koleksi
  void updateListView() {
    final Future<Database> dbFuture = sqfliteHelper.initDb();
    dbFuture.then((database) {
      Future<List<Collection>> collectionListFuture =
          sqfliteHelper.getCollectionList();
      collectionListFuture.then((collectionList) {
        setState(() {
          this.collectionList = collectionList;
          this.count = collectionList.length;
        });
      });
    });
  }
}
