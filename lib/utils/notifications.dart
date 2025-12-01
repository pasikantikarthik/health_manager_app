import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin _fln = FlutterLocalNotificationsPlugin();

class Notifications {
  static Future<void> init() async {
    tzdata.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _fln.initialize(const InitializationSettings(android: android, iOS: ios));
  }

  static Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDateTime,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime.from(scheduledDateTime, tz.local);
    if (scheduled.isBefore(now)) scheduled = scheduled.add(const Duration(days: 1));

    final androidDetails = AndroidNotificationDetails(
      'medicine_channel',
      'Medicine reminders',
      channelDescription: 'Reminders to take medicine',
      importance: Importance.max,
      priority: Priority.high,
    );
    final iosDetails = DarwinNotificationDetails();
    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _fln.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
