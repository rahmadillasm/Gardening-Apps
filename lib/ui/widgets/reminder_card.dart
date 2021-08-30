part of 'widgets.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ReminderCard(
      this.reminder, this.setData, this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    final bool isEnd = DateTime.now().millisecondsSinceEpoch > reminder.time;

    return Card(
      elevation: 0,
      color: accentColor2,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        title: Text(
          reminder.name,
          style: darkGreenTextFont.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              decoration: isEnd ? TextDecoration.lineThrough : null),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          DateFormat("HH:mm")
              .format(DateTime.fromMillisecondsSinceEpoch(reminder.time)),
          style: TextStyle(
              color: accentColor1,
              fontWeight: FontWeight.w400,
              fontSize: 15,
              decoration: isEnd ? TextDecoration.lineThrough : null),
        ),
        trailing: GestureDetector(
          child: Icon(
            Icons.delete,
            color: accentColor1,
          ),
          onTap: () => _showDeleteDialog(
              context, reminder.name, reminder.id, reminder.notifyId),
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, String reminderName, int reminderId, int notifyId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Hapus ?"),
              content:
                  Text("Apakah anda yakin ingin menghapus $reminderName ?"),
              contentTextStyle:
                  TextStyle(fontSize: 17, color: Colors.grey[800]),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: darkGreenTextFont,
                  ),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.3),
                    onPressed: () async {
                      await SqfliteHelper().deleteReminder('Reminder', reminderId);
                      await Notifications().removeNotify(
                          notifyId, flutterLocalNotificationsPlugin);
                      setData();
                      Navigator.pop(context);
                    },
                    child: Text("Hapus", style: darkGreenTextFont))
              ],
            ));
  }
}
