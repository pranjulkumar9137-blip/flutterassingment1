import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Initialize timezone database
    tz.initializeTimeZones();

    // Get device timezone
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(
      tz.getLocation(timezoneInfo.identifier),
    );

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      settings: settings,
    );

    // Android notification permission
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.requestNotificationsPermission();

    // Exact alarm permission
    await androidPlugin?.requestExactAlarmsPermission();
  }

  static Future<void> scheduleReminder({
    required int notificationId,
    required String title,
    required String body,
    required DateTime reminderTime,
  }) async {
    if (reminderTime.isBefore(DateTime.now())) {
      return;
    }

    final scheduledDate = tz.TZDateTime.from(
      reminderTime,
      tz.local,
    );

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'todo_reminders',
      'TODO Reminders',
      channelDescription: 'Notifications for TODO task reminders',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidDetails,
    );

    await _notifications.zonedSchedule(
      id: notificationId,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> cancelReminder(int notificationId) async {
    await _notifications.cancel(id: notificationId);
  }
}