import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../enums/local_service.dart';

class LocalServiceWeb {
  static LocalServiceWeb? _instance;

  LocalServiceWeb._();

  factory LocalServiceWeb() {
    _instance ??= LocalServiceWeb._();
    return _instance!;
  }

  Box? _localObjectBox;

  getInstance() async {
    if (_localObjectBox != null) {
      return;
    }
    const storage = FlutterSecureStorage();
    String? encryptKey = await storage.read(key: "key");

    if (encryptKey == null) {
      var key1 = Hive.generateSecureKey();
      await storage.write(key: "key", value: base64.encode(key1));
      encryptKey = await storage.read(key: "key");
    }
    List<int> key = base64.decode(encryptKey!);

    Hive.init('/');

    _localObjectBox =
        await Hive.openBox('APP_DATA', encryptionCipher: HiveAesCipher(key));
  }

  saveValue(LocalDataFieldName localDataFieldName, dynamic value) async {
    await getInstance();
    _localObjectBox?.put(localDataFieldName.toString(), value);
  }

  dynamic getSavedValue(LocalDataFieldName localDataFieldName) async {
    await getInstance();
    return _localObjectBox?.get(localDataFieldName.toString());
  }

  deleteSavedValue(LocalDataFieldName localDataFieldName) async {
    await getInstance();
    _localObjectBox?.delete(localDataFieldName.toString());
  }

  deleteAllSavedValue() async {
    await getInstance();
    _localObjectBox?.clear();
  }

  deleteAll() async {
    await deleteAllSavedValue();
  }
}
