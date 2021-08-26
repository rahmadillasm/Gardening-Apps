part of 'pages.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  // ignore: deprecated_member_use
  List<Reminder> allListOfReminder = List<Reminder>();
  // ignore: deprecated_member_use
  List<Reminder> dailyReminder = List<Reminder>();
  final SqfliteHelper _sqfliteHelper = SqfliteHelper();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final Notifications _notifications = Notifications();

  final CalendarDayModel _days = CalendarDayModel();
  List<CalendarDayModel> _dayList;

  int _lastChooseDay = 0;

  @override
  void initState() {
    super.initState();
    iniNotifies();
    setData();
    _dayList = _days.getCurrentDays();
  }

  Future iniNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  Future setData() async {
    allListOfReminder.clear();
    (await _sqfliteHelper.selectReminder("Reminder")).forEach((reminderMap) {
      allListOfReminder.add(Reminder().reminderMapToObject(reminderMap));
    });
    chooseDay(_dayList[_lastChooseDay]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Kalender",
          style: whiteTextFont,
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        bottomOpacity: 0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ReminderFormPage(),
                ),
              )
              .then((_) => setData());
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Calendar(chooseDay, _dayList),
              ),
              SizedBox(height: 20),
              dailyReminder.isEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Tidak Ada Pengingat",
                        textAlign: TextAlign.center,
                        style: darkGreenTextFont.copyWith(fontSize: 18),
                      ),
                    )
                  : ReminderList(
                      dailyReminder, setData, flutterLocalNotificationsPlugin)
            ],
          ),
        ),
      ),
    );
  }

  void chooseDay(CalendarDayModel clickedDay) {
    setState(() {
      _lastChooseDay = _dayList.indexOf(clickedDay);
      _dayList.forEach((day) => day.isChecked = false);
      CalendarDayModel chooseDay = _dayList[_dayList.indexOf(clickedDay)];
      chooseDay.isChecked = true;
      dailyReminder.clear();
      allListOfReminder.forEach((reminder) {
        DateTime reminderDate =
            DateTime.fromMicrosecondsSinceEpoch(reminder.time * 1000);
        if (chooseDay.dayNumber == reminderDate.day &&
            chooseDay.month == reminderDate.month &&
            chooseDay.year == reminderDate.year) {
          dailyReminder.add(reminder);
        }
      });
      dailyReminder.sort(
          (reminder1, reminder2) => reminder1.time.compareTo(reminder2.time));
    });
  }
}
