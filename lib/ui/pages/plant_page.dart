part of 'pages.dart';

// ignore: must_be_immutable
class PlantPage extends StatelessWidget {
  List<Plant> plantList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height / 1.2 - 20,
                child: CustomTabBar(),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(
              //       defaultMargin, 15, defaultMargin, 15),
              //   child: Text("Tanaman Hari Ini",
              //       style: darkGreenTextFont.copyWith(
              //           fontWeight: FontWeight.bold, fontSize: 16)),
              // ),
              // Container(
              //   height: size.height / 6,
              //   child: randomListView(),
              // ),
              SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }

  ListView randomListView() {
    if (this.plantList == null) return null;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plantList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => PlantDetailPage(plantList[index])),
              );
            },
            child: Card(
              color: accentColor2,
              elevation: 0,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          plantList[index].picture,
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
                          Text(plantList[index].name,
                              style: darkGreenTextFont.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          SizedBox(height: 5),
                          Text(plantList[index].description,
                              style: darkGreenTextFont, maxLines: 3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
