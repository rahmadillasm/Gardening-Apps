part of 'widgets.dart';

class Notifications {
  BuildContext _context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  Future<FlutterLocalNotificationsPlugin> initNotifies(
      BuildContext context) async {
    this._context = context;

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    return flutterLocalNotificationsPlugin;
  }

  Future showNotification(String title, String description, int time, int id,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id.toInt(),
        title,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: time)),
        const NotificationDetails(
          android: AndroidNotificationDetails('schedule_id', 'schedule', 'schedule_notification_channel',
          importance: Importance.high,
          priority: Priority.high,
          color: Colors.cyanAccent,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future removeNotify(int notifyId, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      return await flutterLocalNotificationsPlugin.cancel(notifyId);
    } catch (e) {
      return null;
    }
  }

  Future onSelectNotification(String payload) async {
    showDialog(
        context: _context,
        builder: (_) {
          return AlertDialog(
            title: Text("Payload"),
            content: Text("Payload : $payload"),
          );
        });
  }
}
