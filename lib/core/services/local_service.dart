import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../enums/local_service.dart';

Future<Map<String, dynamic>> isolateTransformDataDictionaryListToMap(
    dynamic dataList) async {
  var results = await compute(mapDataDictionaryListToMap, dataList);
  return results;
}

Map<String, dynamic> mapDataDictionaryListToMap(dynamic dataList) {
  Map<String, dynamic> results = {};

  for (var data in dataList) {
    results[data["code"]] = data;
  }

  return results;
}

class LocalService {
  static LocalService? _instance;

  LocalService._();

  factory LocalService() {
    _instance ??= LocalService._();
    return _instance!;
  }

  late Box _localObjectBox;

  /// Dynamic form data
  late Box _localDynamicFormBox;

  /// MSO data boxes
  late Box _localAccountCurrencyBox;
  late Box _localSavingPurpose;
  late Box _localFundSource;
  late Box _localDepositor;

  List<int>? _secureKey;

  getInstance() async {
    final directory = await getApplicationDocumentsDirectory();
    const storage = FlutterSecureStorage();
    String? encryptKey = await storage.read(key: "key");

    if (encryptKey == null) {
      var key1 = Hive.generateSecureKey();
      await storage.write(key: "key", value: base64.encode(key1));
      encryptKey = await storage.read(key: "key");
    }
    List<int> key = base64.decode(encryptKey!);
    _secureKey = key;

    Hive.init(directory.path);

    _localObjectBox =
        await Hive.openBox('APP_DATA', encryptionCipher: HiveAesCipher(key));
  }

  saveValue(LocalDataFieldName localDataFieldName, dynamic value) async {
    if (_localObjectBox == null || _localObjectBox.isEmpty) {
      await getInstance();
    }
    _localObjectBox.put(localDataFieldName.toString(), value);
  }

  dynamic getSavedValue(LocalDataFieldName localDataFieldName) async {
    if (_localObjectBox == null) {
      await getInstance();
    }
    return _localObjectBox.get(localDataFieldName.toString());
  }

  deleteSavedValue(LocalDataFieldName localDataFieldName) async {
    if (_localObjectBox == null) {
      await getInstance();
    }

    _localObjectBox.delete(localDataFieldName.toString());
  }

  deleteAllSavedValue() async {
    if (_localObjectBox == null) {
      await getInstance();
    }
    _localObjectBox.clear();
  }

  deleteAll() async {
    await deleteAllSavedValue();
  }
}
