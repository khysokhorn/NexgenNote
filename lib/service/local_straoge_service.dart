import 'package:hive_flutter/hive_flutter.dart';
import 'package:googleapis/sheets/v4.dart' as sheet;

class LocalStraogeService {
  final sheet.SheetsApi sheetsApi;
  final List<String> _localStorageKey = ['Income'];
  Box<String?>? _favoriteBooksBox;
  LocalStraogeService({required this.sheetsApi});
  initservice() {
    Hive.initFlutter();
  }

  Future<String> saveNameRage(String fileId) async {
    for (var k in _localStorageKey) {
      var responseNameRange =
          await sheetsApi.spreadsheets.values.get(fileId, k);
      await Hive.openBox<String>(k);
      _favoriteBooksBox = Hive.box<String>(k);
      if (responseNameRange.values != null) {
        for (var value in responseNameRange.values!) {
          _favoriteBooksBox?.add(value.first.toString());
        }
      }

      //
    }
    return '';
  }

  Future<List<String>> getDropdownValue(String key) async {
    await Hive.openBox<String>(key);
    Map<String, String> map = Hive.box<String>(key)
        .toMap()
        .map((key, value) => MapEntry(key.toString(), value));
    return map.values.toList();
  }

  deleteByKey(String key) async {
    var b = await Hive.openBox<String>(key);
    await b.clear(); 
  }
}
