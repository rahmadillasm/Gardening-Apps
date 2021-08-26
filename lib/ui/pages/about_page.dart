part of 'pages.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        title: Text("Tentang Aplikasi"),
        centerTitle: true,
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
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            child: Center(
              child: Image.asset(
                "assets/images/apps.png",
                height: 130,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: accentColor1, width: 1),
            ),
            child: Text(
              '\t\t\t\tAplikasi Gardening Apps merupakan aplikasi berbasis android yang dibuat dengan tujuan untuk mengedukasi pengguna mengenai tanaman hortikultura seperti tanaman hias, tanaman obat dan tanaman sayuran. \n\t\t\t\tAplikasi ini menyajikan berbagai informasi mengenai tanaman termasuk tips perawatan yang baik dan benar.',
              style: darkGreenTextFont,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
