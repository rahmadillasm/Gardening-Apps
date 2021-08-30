part of 'pages.dart';

// ignore: must_be_immutable
class PlantDetailPage extends StatelessWidget {
  Plant plantDetail;

  PlantDetailPage(Plant plantConstructor) {
    this.plantDetail = plantConstructor;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: accentColor3,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Ink(
            decoration: ShapeDecoration(
              color: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: size.height / 3 + 15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(this.plantDetail.picture),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height / 3 - 10),
                  padding: EdgeInsets.symmetric(
                      vertical: defaultMargin, horizontal: defaultMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: accentColor3,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(this.plantDetail.name,
                              style: darkGreenTextFont.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text(
                            this.plantDetail.description,
                            style: darkGreenTextFont,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60,
                              width: size.width / 3.5,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    height: 30,
                                    child: Image.asset(
                                      "assets/icons/ic_water.png",
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Column(
                                    children: [
                                      Text("Air",
                                          style: whiteTextFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Text(this.plantDetail.water,
                                          style: whiteTextFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              width: size.width / 3.5,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    height: 30,
                                    child: Image.asset(
                                      "assets/icons/ic_temperature.png",
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Column(
                                    children: [
                                      Text("Temp.",
                                          style: whiteTextFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Text(this.plantDetail.temperatur,
                                          style: whiteTextFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              width: size.width / 3.5,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    height: 30,
                                    child: Image.asset(
                                      "assets/icons/ic_light.png",
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Column(
                                    children: [
                                      Text("Cahaya",
                                          style: whiteTextFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Text(this.plantDetail.light,
                                          style: whiteTextFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(8),
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: accentColor1, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Tips Perawatan',
                                style: darkGreenTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                this.plantDetail.tips,
                                style: darkGreenTextFont,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
