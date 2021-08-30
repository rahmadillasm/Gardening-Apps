part of 'pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainPage()),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/ic_splash.png"),
            ),
          ),
        ),
      ),
    );
  }
}
