import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsApiData {
  String url;
  String clientId;
  String? spreadsheetId;
  String clientEmail;
  String privateKey;
  String? gid;

  GoogleSheetsApiData(
      {required this.clientEmail,
      required this.clientId,
      required this.privateKey,
      required this.url});

  void extractGidAndIdFromUrl(String url) {
    Uri uri = Uri.parse(url);

    // Extract spreadsheet ID
    String path = uri.path;
    List<String> pathSegments = path.split('/');

    if (pathSegments.length > 2) {
      spreadsheetId = pathSegments[3];
    }

    // Extract gid
    String fragment = uri.fragment;

    if (fragment.contains("gid=")) {
      gid = fragment.split("gid=")[1];
    }
  }

  Future<dynamic> accessGoogleSheetData() async {
    // extract GID and spreadsheet Id from url
    extractGidAndIdFromUrl(url);

    // Your Google Sheets API credentials
    final credentials = ServiceAccountCredentials.fromJson({
      'client_id': clientId,
      // Your service account email
      'client_email': clientEmail,
      // Your private key
      'private_key': privateKey,
      // Google Sheets API scope
      'scopes': [SheetsApi.spreadsheetsReadonlyScope],
      'type': 'service_account'
    });

    final client = await clientViaServiceAccount(
        credentials, [SheetsApi.spreadsheetsReadonlyScope]);

    // Google Sheets API instance
    final sheets = SheetsApi(client);
    // Spreadsheet ID and range

    try {
      // Retrieve data from Google Sheets

      var allTabSheets = await sheets.spreadsheets.get(spreadsheetId!);

      // log("sheet tab length: ${allTabSheets.sheets?.length}");
      Sheet? sheet = allTabSheets.sheets?.firstWhere((sheet) {
        // log("${sheet.properties?.sheetId}");
        return sheet.properties?.sheetId.toString() == gid;
      });

      final range = '${sheet?.properties?.title}';

      // log("sheet name.. $range");
      var response =
          await sheets.spreadsheets.values.get(spreadsheetId!, range);

      return response;
    } finally {
      // Close the HTTP client to release resources
      client.close();
    }
  }
}
