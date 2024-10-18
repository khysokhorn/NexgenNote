import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheet;
import 'package:noteapp/core/enums/screen_type.dart';
import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/services/api_provider_service.dart';
import 'package:noteapp/ui/views/home/home_screen.dart';

class GoogleApiService {
  List<String> scopes = <String>[
    'email',
    sheet.SheetsApi.driveFileScope,
    sheet.SheetsApi.spreadsheetsScope,
    drive.DriveApi.driveFileScope,
    drive.DriveApi.driveMetadataReadonlyScope,
  ];

  late GoogleSignIn _googleSignIn;

  initData() async {
    _googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    _googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) async {
        bool isAuthorized = account != null;
        if (account != null) {
          var auth = await account.authHeaders;
          if (auth.isNotEmpty) {
            ApiProviderService().setUserAccessToken(
              auth['Authorization']!,
              auth['X-Goog-AuthUser']!,
            );
            startNewScreen(
              ScreenType.SCREEN_WIDGET_REPLACEMENT,
              HomeScreen(),
            );
          }
          _googleSignIn.signInSilently();
        }
      },
    );
  }

  signIn() async {
    await _googleSignIn.signIn();
  }
}
