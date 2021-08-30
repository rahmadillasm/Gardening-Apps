part of 'pages.dart';

class ReminderFormPage extends StatefulWidget {
  @override
  _ReminderFormPageState createState() => _ReminderFormPageState();
}

class _ReminderFormPageState extends State<ReminderFormPage> {
  final Snackbar snackbar = Snackbar();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController nameController = TextEditingController();
  DateTime setDate = DateTime.now();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final Notifications _notifications = Notifications();
  final SqfliteHelper _sqfliteHelper= SqfliteHelper();

  @override
  void initState() {
    super.initState();
    initNotifies();
  }

  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        title: Text(
          "Tambah Pengingat",
          style: whiteTextFont,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _formFields(context),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _formFields(BuildContext context) {
    final focus = FocusScope.of(context);

    return LayoutBuilder(
      builder: (context, constrains) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          //nama kegiatan /pills name
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor1),
                    borderRadius: BorderRadius.circular(15)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor1),
                    borderRadius: BorderRadius.circular(15)),
                labelText: "Nama Kegiatan",
                labelStyle: darkGreenTextFont,
                hintText: "Masukkan Nama Kegiatan",
                hintStyle: TextStyle(color: accentColor2),
                filled: true,
              ),
              onSubmitted: (val) => focus.nextFocus(),
            ),
          ),
          SizedBox(height: 15),

          //time picker & date picker
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),

            height: 50,
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: accentColor3,
              onPressed: () {
                openTimePicker();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.Hm().format(this.setDate),
                    style: darkGreenTextFont,
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Icon(
                    Icons.access_alarm_rounded,
                    size: 30,
                    color: accentColor1,
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: accentColor1),
              ),
            ),
          ),

          SizedBox(height: 15),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: accentColor3,
              onPressed: () {
                openDatePicker();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    DateFormat("dd-MM-yyyy").format(this.setDate),
                    style: darkGreenTextFont,
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Icon(
                    Icons.event_outlined,
                    size: 30,
                    color: accentColor1,
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: accentColor1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          // ignore: deprecated_member_use
          child: RaisedButton(
            color: mainColor,
            onPressed: () {
              saveReminder();
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

  Future<void> openTimePicker() async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF8CE7F1),
            accentColor: mainColor,
            colorScheme: ColorScheme.light(
              primary: accentColor1,
              onPrimary: Colors.white,
              surface: accentColor3,
              onSurface: mainColor,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
      helpText: "Pilih Waktu",
    ).then((value) {
      DateTime newDate = DateTime(
          setDate.year,
          setDate.month,
          setDate.day,
          value != null ? value.hour : setDate.hour,
          value != null ? value.minute : setDate.minute);
      setState(() => setDate = newDate);
      print(newDate.hour);
      print(newDate.minute);
    });
  }

  Future<void> openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: setDate,
            helpText: "Pilih Tanggal",
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: accentColor1,
                    onPrimary: Colors.white,
                    surface: mainColor,
                    onSurface: accentColor1,
                  ),
                  dialogBackgroundColor: accentColor3,
                ),
                child: child,
              );
            },
            firstDate: DateTime(2000),
            lastDate: DateTime.now().add(Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);
      setState(() => setDate = newDate);
      print(setDate.day);
      print(setDate.month);
      print(setDate.year);
    });
  }

  Future saveReminder() async {
    if (setDate.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch) {
      snackbar.showSnack(
          "Periksa tanggal dan waktu pengingat", _scaffoldKey, null);
    } else {
      Reminder reminder = Reminder(
          name: nameController.text,
          time: setDate.millisecondsSinceEpoch,
          notifyId: Random().nextInt(10000000));

      dynamic result =
          await _sqfliteHelper.insertReminder('reminder', reminder.reminderToMap());
      if (result == null) {
        snackbar.showSnack("Something went wrong", _scaffoldKey, null);
        return;
      } else {
        tz.initializeTimeZones();
        tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));
        await _notifications.showNotification(reminder.name, reminder.name,
            time, reminder.notifyId, flutterLocalNotificationsPlugin);
        setDate = setDate.add(Duration(milliseconds: 604800000));
        reminder.time = setDate.millisecondsSinceEpoch;
        reminder.notifyId = Random().nextInt(10000000);
      }
      snackbar.showSnack("Saved", _scaffoldKey, null);
      Navigator.pop(context);
    }
  }

  int get time =>
      setDate.millisecondsSinceEpoch -
      tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
}
