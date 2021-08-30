part of 'widgets.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: mainColor,
            ),
            child: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/logo_white.png"),
              //   ),
              // ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: accentColor1),
            title: Text("Tentang Aplikasi", style: darkGreenTextFont),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: accentColor1),
            title: Text("Keluar", style: darkGreenTextFont),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => exit(0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
