
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

// import '../global_function.dart';
// import '../utill/app_constants.dart';

// class NotificationService {

//   static NotificationService? _instance;
//   MacOsDeviceInfo? _device;

//   NotificationService._();

//   factory NotificationService() {
//     _instance ??= NotificationService._();
//     return _instance!;
//   }

//   Future<void> getInstance() async {

//     //Remove this method to stop OneSignal Debugging
//     OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

//     OneSignal.shared.setAppId(ONESIGNAL_APP_ID);

//     // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//     OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//       GlobalFunction.printDebugMessage("Accepted permission: $accepted");
//     });

//     OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
//       // Will be called whenever a notification is received in foreground
//       // Display Notification, pass null param for not displaying the notification
//       event.complete(event.notification);
//     });

//     OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//       // Will be called whenever a notification is opened/button pressed.
//     });

//     OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
//       // Will be called whenever the permission changes
//       // (ie. user taps Allow on the permission prompt in iOS)
//     });

//     OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
//       // Will be called whenever the subscription changes
//       // (ie. user gets registered with OneSignal and gets a user ID)
//     });

//     OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
//       // Will be called whenever then user's email subscription changes
//       // (ie. OneSignal.setEmail(email) is called and the user gets registered
//     });

//     _device = await OneSignal.shared.getDeviceState();

//     GlobalFunction.printDebugMessage("Push user id: ${_device?.userId}");
//     GlobalFunction.printDebugMessage("Push token: ${_device?.pushToken}");

//   }

//   String? get userId => _device?.userId;

//   sendTags(Map<String, dynamic> tags) async {
//     await OneSignal.shared.sendTags(tags);
//   }

//   deleteTags(List<String> keys) async {
//     OneSignal.shared.deleteTags(keys);
//   }

// }