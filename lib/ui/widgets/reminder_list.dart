part of 'widgets.dart';

class ReminderList extends StatelessWidget {
  final List<Reminder> listOfReminder;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ReminderList(this.listOfReminder, this.setData, this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ReminderCard(listOfReminder[index], setData, flutterLocalNotificationsPlugin),
      itemCount: listOfReminder.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}