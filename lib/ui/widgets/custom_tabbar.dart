part of 'widgets.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;

  SqfliteHelper sqfliteHelper = SqfliteHelper();
  int count = 0;
  List<Plant> plantList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    updateListView();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              top: 15,
            ),
            centerTitle: true,
            title: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Selamat Datang !",
                            style: whiteTextFont.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage("assets/images/Logo.png"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7),
                  // CustomSearchBar(),
                ],
              ),
            ),
          ),
          bottom: PreferredSize(
            child: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Tanaman\nHias",
                    style: whiteTextFont,
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Tanaman\nObat",
                    style: whiteTextFont,
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Tanaman\nSayuran",
                    style: whiteTextFont,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
              controller: _tabController,
              indicatorColor: accentColor3,
              indicatorSize: TabBarIndicatorSize.label,
            ),
            preferredSize: Size.square(80),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: createListView("Tanaman Hias"),
            ),
            Container(
              child: createListView("Tanaman Obat"),
            ),
            Container(
              child: createListView("Tanaman Sayuran"),
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  //filter by search bar
  // void filterPlantList(String searchKey) {
  //   this.plantList = this.plantList.where((item){
  //     return item.name.contains(searchKey);
  //   });
  // }

  ListView createListView(String categoryName) {
    if (this.plantList == null) return null;

    List<Plant> filteredPlantByCategory = this.plantList.where((item) {
      return item.category == categoryName;
    }).toList();

    return ListView.builder(
      itemCount: filteredPlantByCategory.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      PlantDetailPage(filteredPlantByCategory[index])),
            );
          },
          child: Card(
            color: accentColor2,
            elevation: 0,
            margin: EdgeInsets.only(
              top: (index == 0) ? 15 : 0,
              bottom: 10,
              // bottom: (index == filteredPlantByCategory.length - 1) ? 80 : 10,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        filteredPlantByCategory[index].picture,
                        fit: BoxFit.cover,
                        height: 80,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(filteredPlantByCategory[index].name,
                            style: darkGreenTextFont.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(height: 5),
                        Text(filteredPlantByCategory[index].description,
                            style: darkGreenTextFont.copyWith(fontSize: 13),
                            maxLines: 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = sqfliteHelper.initDb();
    dbFuture.then((database) {
      Future<List<Plant>> plantListFuture =
          sqfliteHelper.getPlantListFromJsonFile(context);
      plantListFuture.then((plantList) {
        setState(() {
          this.plantList = plantList;
          this.count = plantList.length;
        });
      });
    });
  }
}
