part of 'pages.dart';

class CollectionFormPage extends StatefulWidget {
  final Collection collection;

  CollectionFormPage(this.collection);

  @override
  CollectionFormPageState createState() =>
      CollectionFormPageState(this.collection);
}

//class controller
class CollectionFormPageState extends State<CollectionFormPage> {
  Collection collection;

  CollectionFormPageState(this.collection);

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (collection != null) {
      nameController.text = collection.name;
      categoryController.text = collection.category;
      placeController.text = collection.place;
      notesController.text = collection.notes;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        bottomOpacity: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: accentColor3,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: (collection == null)
            ? Text("Tambah Koleksi", style: whiteTextFont)
            : Text("Edit Koleksi", style: whiteTextFont),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  _textField(),
                  _buildButton(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textField() {
    return Column(
      children: [
        SizedBox(height: 20),
        //nama
        Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor1),
                  borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor1),
                  borderRadius: BorderRadius.circular(15)),
              labelText: "Nama Tanaman",
              labelStyle: darkGreenTextFont,
              hintText: "Masukkan Nama Tanaman",
              hintStyle: TextStyle(color: accentColor2),
              filled: true,
            ),
            // validator: Validation.validateCollection,
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 15),
        //category
        Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: categoryController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor1),
                  borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor1),
                  borderRadius: BorderRadius.circular(15)),
              labelText: "Jenis Tanaman",
              labelStyle: darkGreenTextFont,
              hintText: "Masukkan Nama Jenis Tanaman",
              hintStyle: TextStyle(color: accentColor2),
              filled: true,
            ),
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 15),
        //place
        Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: placeController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor1),
                  borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor1),
                  borderRadius: BorderRadius.circular(15)),
              labelText: "Letak Tanaman",
              labelStyle: darkGreenTextFont,
              hintText: "Masukkan Letak Tanaman",
              hintStyle: TextStyle(color: accentColor2),
              filled: true,
            ),
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          height: 120,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: notesController,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor1),
                  borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor1),
                  borderRadius: BorderRadius.circular(15)),
              labelText: "Catatan",
              labelStyle: darkGreenTextFont,
              hintText: "Masukkan Catatan",
              hintStyle: TextStyle(color: accentColor2),
              filled: true,
            ),
            onChanged: (value) {},
          ),
        )
      ],
    );
  }

  Widget _buildButton(context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          // ignore: deprecated_member_use
          child: RaisedButton(
            color: mainColor,
            onPressed: () {
              if (collection == null) {
                //tambah data
                collection = Collection(
                    nameController.text,
                    categoryController.text,
                    placeController.text,
                    notesController.text);
              } else {
                //ubah data
                collection.name = nameController.text;
                collection.category = categoryController.text;
                collection.place = placeController.text;
                collection.notes = notesController.text;
              }
              Navigator.pop(context, collection);
            },
            child: Text(
              "Simpan",
              style: whiteTextFont,
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
