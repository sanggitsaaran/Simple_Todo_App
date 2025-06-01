import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initNotification() {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    _notificationsPlugin.initialize(initializationSettings);
  }

  void scheduleNotification(int id, DateTime dateTime, String task) async {
    if (dateTime.isBefore(DateTime.now())) {
      print("Scheduled time ($dateTime) is in the past for task '$task'. Notification not scheduled.");
      return;
    }
    await _notificationsPlugin.zonedSchedule(
      id,
      'Task Reminder',
      task,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_channel',
          'Task Reminders',
          channelDescription: 'Notifications for task reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
    print("Notification scheduled for '$task' at $dateTime with ID $id");
  }
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
    print("Cancelled notification with ID: $id");
  }

  // --- NEW METHOD (Optional, but good practice) to cancel all notifications ---
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
    print("Cancelled all notifications");
  }
}
