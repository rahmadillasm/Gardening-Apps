part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int bottomNavBarIndex; //untuk mengatur navigation bar yang dibawah
  int appBarIndex;
  PageController pageController; //untuk mengatur page view

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = 0;
    appBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
    pageController = PageController(initialPage: appBarIndex);
  }

  // // function buat appbar action
  // List<Widget> getAction(int appBarIndex) {
  //   if (appBarIndex == 0) {
  //     return [];
  //   } else {
  //     return [
  //       IconButton(
  //         icon: Icon(Icons.add, color: accentColor3),
  //         onPressed: () async {
  //           // var collection = await navigateToCollectionForm(context, null);
  //           // if (collection != null) addCollection(collection);
  //         },
  //       ),
  //     ];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: createCustomAppBar(),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(color: accentColor3),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              //kalo page nya berubah, bottomnavbarindex indexnya disesuaikan dengan index yang terpilih
              setState(() {
                bottomNavBarIndex = index;
                appBarIndex = index;
              });
            },
            children: [
              PlantPage(), //index = 0
              CollectionPage(), //index = 1
            ],
          ),

          //BOTTOM
          createCustomBottomNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 46,
              width: 46,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: mainColor,
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: Container(
                    margin: EdgeInsets.all(1),
                    child: Image.asset("assets/icons/ic_calendar_off.png"),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReminderPage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createCustomBottomNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: accentColor3,
              unselectedItemColor: accentColor2,
              currentIndex: bottomNavBarIndex,
              onTap: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                  pageController.jumpToPage(
                      index); //ketika ditap pagenya juga akan pindah
                });
              },
              items: [
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text(
                    "Beranda",
                    style: whiteTextFont.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset(
                      (bottomNavBarIndex == 0)
                          ? "assets/icons/ic_home_on.png"
                          : "assets/icons/ic_home_off.png",
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text(
                    "Koleksi",
                    style: whiteTextFont.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset(
                      (bottomNavBarIndex == 1)
                          ? "assets/icons/ic_collection_on.png"
                          : "assets/icons/ic_collection_off.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget createCustomAppBar() => AppBar(
        backgroundColor: mainColor,
        bottomOpacity: 0,
        elevation: 0,
        shape: (appBarIndex == 0)
            ? null
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
        leading: Padding(
          padding: EdgeInsets.all(8),
          // ignore: deprecated_member_use
          child: IconButton(
            icon: Container(
              margin: EdgeInsets.all(3),
              child: Image.asset("assets/icons/ic_menu.png"),
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        title: (appBarIndex == 0)
            ? null
            : Text(
                "Koleksi",
                style: whiteTextFont,
              ),
        centerTitle: true,
        // actions: getAction(appBarIndex),
      );
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
//CUSTOM UKURAN NAVBAR
    //setengah kanan navigasi
    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    //setengah kiri navigasi
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    //kebawah
    path.lineTo(size.width, size.height);
    //garis horizontal bawah
    path.lineTo(0, size.height);
    //keatas
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
