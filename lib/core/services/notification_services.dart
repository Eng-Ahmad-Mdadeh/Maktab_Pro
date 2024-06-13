import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../data/models/notification/notification_model.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static late PusherChannelsFlutter pusher;

  static Future<void> init(int id) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
    );
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: 'ca0abe9343a3d7744c35',
        authEndpoint: "https://maktab.sa",
        cluster: 'eu',
        onConnectionStateChange: (a, b) {
          log("pusher $a $b");
        },
        // onConnectionStateChange: onConnectionStateChange,
        // onError: onError,
        // onSubscriptionSucceeded: onSubscriptionSucceeded,
        //   onEvent: (PusherEvent? event){
        //   log("NEW MESSAGE");
        //   showNotification(event?.data.toString()??"");
        // },
        // onSubscriptionError: onSubscriptionError,
        // onDecryptionFailure: onDecryptionFailure,
        // onMemberAdded: onMemberAdded,
        // onMemberRemoved: onMemberRemoved,

        // onAuthorizer: onAuthorizer
      );
      await pusher.connect();

      log("pusher channels: ${pusher.channels}");
      log("pusher connectionState: ${pusher.connectionState}");
      log("pusher methodChannel: ${pusher.methodChannel.name}");

      await pusher.subscribe(
          channelName: 'channel_orders_business.$id',
          onEvent: (event) {
            log("channel_orders_business NEW MESSAGE: $event");
            if (event?.eventName == 'event-business-orders') {
              log("event.data.runtimeType: ${event.data.runtimeType}");
              showNotification(event?.data.toString() ?? '');
            }
          });
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Future<void> initializePusher() async {}

  static Future<void> showNotification(String message) async {
    PermissionStatus status = await Permission.notification.request();

    if(status.isGranted){
      log("notification isGranted");
    }

    final notificationJson = jsonDecode(message);
    final NotificationModel notification = NotificationModel.fromJson(notificationJson['notification']);

    log("notification is: $notification");

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_bankPayment_business.2',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      notification.arTitle,
      notification.arBody,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void dispose() {
    pusher.disconnect();
  }

// static Future<void> showNotification({
//   required String title,
//   required String body,
// }) async {
//   const android = AndroidNotificationDetails(
//     'channel id',
//     'channel name',
//     priority: Priority.high,
//     importance: Importance.max,
//     channelShowBadge: false,
//     onlyAlertOnce: true,
//   );
//   const iOS = DarwinNotificationDetails();
//   const platform = NotificationDetails(android: android, iOS: iOS);
//   await flutterLocalNotificationsPlugin.show(
//       math.Random().nextInt(100), title, body, platform);
// }
}
