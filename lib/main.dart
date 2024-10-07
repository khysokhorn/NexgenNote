import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheet;

import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/service/local_straoge_service.dart';

/// The scopes required by this application.
// #docregion Initialize
const List<String> scopes = <String>[
  'email',
  sheet.SheetsApi.driveFileScope,
  sheet.SheetsApi.spreadsheetsScope,
  drive.DriveApi.driveFileScope,
  drive.DriveApi.driveMetadataReadonlyScope,
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  clientId: "",
  scopes: scopes,
);
// #enddocregion Initialize

void main() async {
  await Hive.initFlutter();
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
    ),
  );
}

/// The SignInDemo app.
class SignInDemo extends StatefulWidget {
  ///
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';
  LocalStraogeService? localStraogeService;
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
// #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
        var auth = await account.authHeaders;
        var client = GoogleAuthClient(auth);
        drive.DriveApi(client);

        // Initialize Google Sheets API
      }
// #enddocregion CanAccessScopes

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
      var auth = await account?.authHeaders;
      if (auth != null) {
        var client = GoogleAuthClient(auth);
        var sheetsApi = sheet.SheetsApi(client);
        localStraogeService = LocalStraogeService(sheetsApi: sheetsApi);
        localStraogeService?.initservice();
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
  }

  Future<void> listGoogleDriveFiles() async {
    final account = await _googleSignIn.signIn();

    if (account != null) {
      // Get Authenticated HTTP client
      final authHeaders = await account.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);

      // Initialize Google Drive API
      var driveApi = drive.DriveApi(authenticateClient);

      // List files in Google Drive
      var fileList = await driveApi.files.list();
      for (var file in fileList.files!) {
        print('File ID: ${file.id}, Name: ${file.name}');
      }

      accessSpecificFile();
    }
  }

  Future<void> accessSpecificFile(
      {String fileId = '1yvsFK8fXsQkX6bkRntPEgeKaCe-W_KH8ZSDs3vEbENQ'}) async {
    try {
      final account = await _googleSignIn.signIn();

      if (account != null) {
        // Get Authenticated HTTP client
        final authHeaders = await account.authHeaders;
        final authenticateClient = GoogleAuthClient(authHeaders);

        // Initialize Google Sheets API
        var sheetsApi = sheet.SheetsApi(authenticateClient);

        var sheetData = await sheetsApi.spreadsheets.get(
          fileId,
          includeGridData: true,
        );
        var income = "Income";
        var dropdown = await sheetsApi.spreadsheets.values
            .get(fileId, "'គម្រោងចំណូល ចំណាយ តុលា 2024'!I24:I1010");
        localStraogeService?.saveNameRage(fileId);
        print("Dropdonw $dropdown");
        var getDropdown = localStraogeService?.getDropdownValue(income);
        print("Dropdonw $getDropdown");
        var responseNameRange =
            await sheetsApi.spreadsheets.values.get(fileId, income);
        responseNameRange.values?.first.first;
        print(responseNameRange);
        // Iterate through all sheets in the spreadsheet
        // for (var sheet in sheetData.sheets!) {
        //   print('Sheet Title: ${sheet.properties!.title}');
        //   // // Check the data validation rules in the sheet
        //   print("data : ${sheet.data}");
        //   for (var row in sheet.data ?? <GridData>[]) {
        //     for (var cell in row.rowData ?? <RowData>[]) {
        //       if (cell.values?.isNotEmpty ?? false) {
        //         for (var cellValue in cell.values ?? <CellData>[]) {
        //           var condition = cellValue.dataValidation?.condition;
        //           if (condition?.type == "ONE_OF_RANGE") {
        //             String? range = condition!.values![0].userEnteredValue;
        //             range = range?.replaceAll(RegExp(r'["=]'), "");
        //             // Fetch the values from the specified range
        //             try {
        //               var rangeValues = await sheetsApi.spreadsheets.values.get(
        //                 fileId,
        //                 range!,
        //               );
        //               print('Dropdown Values for range $range:');
        //               if (rangeValues.values != null &&
        //                   rangeValues.values!.isNotEmpty) {
        //                 for (var valueRow in rangeValues.values!) {
        //                   if (kDebugMode) {
        //                     print("Row value : ${valueRow}");
        //                   }
        //                 }
        //               } else {
        //                 print('No values found in the specified range.');
        //               }
        //             } catch (e) {
        //               print(e);
        //             }
        //           }
        //         }
        //       }
        //     }
        //   }
        // }
        // Prepare the data to write "Hello World" into Sheet1!A1
        var valueRange = sheet.ValueRange.fromJson({
          "range": "Sheet1!A1", // Specify the range where you want to write
          "majorDimension": "ROWS", // Indicate that you're writing row-wise
          "values": [
            ["Hello World"] // The value you want to write
          ]
        });

        try {
          // Write data to the specified range in the Google Sheet
          var response = await sheetsApi.spreadsheets.values
              .update(valueRange, fileId, "Sheet1!A1", valueInputOption: "RAW");

          print('Data written to Google Sheet successfully!');
        } catch (e) {
          print('Error writing to Google Sheet: $e');
        }
      }
    } catch (e) {
      print('Error reading spreadsheet: $e');
    }
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });

    final http.Response response = await http.get(
      Uri.parse('https://www.googleapis.com/discovery/v1/apis/drive/v3/rest'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  // #docregion SignIn
  Future<void> _handleSignIn() async {
    try {
      var a = await _googleSignIn.signIn();
      print(a);
    } catch (error) {
      print(error);
    }
  }
  // #enddocregion SignIn

  // Prompts the user to authorize `scopes`.
  //
  // This action is **required** in platforms that don't perform Authentication
  // and Authorization at the same time (like the web).
  //
  // On the web, this must be called from an user interaction (button click).
  // #docregion RequestScopes
  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    // #enddocregion RequestScopes
    setState(() {
      _isAuthorized = isAuthorized;
    });
    // #docregion RequestScopes
    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
    // #enddocregion RequestScopes
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      // The user is Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          if (_isAuthorized) ...<Widget>[
            // The user has Authorized all required scopes
            Text(_contactText),
            ElevatedButton(
              child: const Text('REFRESH'),
              onPressed: () => _handleGetContact(user),
            ),
            ElevatedButton(
              child: const Text('Delete dropdown'),
              onPressed: () async {
                var income = "Income";
                await localStraogeService?.deleteByKey(income);
              },
            ),
            ElevatedButton(
              child: const Text('List File '),
              onPressed: listGoogleDriveFiles,
            ),
            ElevatedButton(
              child: const Text('List dropdown'),
              onPressed: listDropDown,
            ),
          ],
          if (!_isAuthorized) ...<Widget>[
            // The user has NOT Authorized all required scopes.
            // (Mobile users may never see this button!)
            const Text('Additional permissions needed to read your contacts.'),
            ElevatedButton(
              onPressed: _handleAuthorizeScopes,
              child: const Text('REQUEST PERMISSIONS'),
            ),
          ],
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
      // The user is NOT Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          // This method is used to separate mobile from web code with conditional exports.
          // See: src/sign_in_button.dart
          TextButton(onPressed: _handleSignIn, child: Text("login"))
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }

  void listDropDown() async {
    await localStraogeService?.getDropdownValue("Income");
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = new http.Client();
  GoogleAuthClient(this._headers);
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
