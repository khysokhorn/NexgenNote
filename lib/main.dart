import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:noteapp/ui/views/home/get_start_screen.dart';
import 'core/services/global_service.dart';
import 'core/utill/app_constants.dart';
import 'core/utill/colors.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('km', 'KH'),
      ],
      path: 'lib/assets/languages',
      // <-- change patch to your
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyAppV2 extends StatelessWidget {
  const MyAppV2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          return locale;
        },
        locale: context.locale,
        title: appName,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primaryColor: PRIMARY_COLOR,
          colorScheme: const ColorScheme.light(
            primary: PRIMARY_COLOR,
            secondary: ACCENT_COLOR,
          ),
          splashColor: SECONDARY_COLOR,
          appBarTheme:  AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          indicatorColor: PRIMARY_COLOR,
          inputDecorationTheme: Theme.of(context).inputDecorationTheme,
        ),
        home: const Scaffold(
          body: GetStartScreen(),
        ),
        navigatorKey: GlobalService().navigator,
      ),
    );
  }
}
