import 'package:flutter/material.dart';

import '../services/global_service.dart';

// Prod
//const String BASE_URL = "https://prathnatech.com:5102";
// const String BASE_URL = "https://www.prathnatech.com:7100";
// Training
//const String BASE_URL = "https://prathnatech.com:5204";
// UAT
const String BASE_URL = "https://www.prathnatech.com:5100";
const String BASE_URL_CROSS_SELLING = "";
const String BASE_CBC_REPORT_URL = "";
const String ONESIGNAL_APP_ID = "";
const String BASE_URL_REPORT = "";
const String APP_VERSION = "v1.0.7";

// Network
const String BASE_API_URL = "$BASE_URL/api/";

const EARLIER_MINUTES_RENEW_TOKEN = 0;

const String appName = "Base Project";

// Theme
TextTheme theme = Theme.of(GlobalService().context).textTheme;

// Notification
class NotificationTypeNames {
  static const String LAF_APP_CREATION = "";
}
