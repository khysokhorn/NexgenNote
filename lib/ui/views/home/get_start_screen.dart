import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:noteapp/core/constant/general_constants.dart';
import 'package:noteapp/core/enums/local_service.dart';
import 'package:noteapp/core/enums/screen_type.dart';
import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/services/api_provider_service.dart';
import 'package:noteapp/core/services/google_api_service.dart';
import 'package:noteapp/core/services/local_service.dart';
import 'package:noteapp/ui/views/Password/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheet;
import 'package:noteapp/ui/views/home/home_screen.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({super.key});

  @override
  GetStartScreenState createState() => GetStartScreenState();
}

class GetStartScreenState extends State<GetStartScreen>
    with SingleTickerProviderStateMixin {
  final introKey = GlobalKey<GetStartScreenState>();
  final _googleApiService = GoogleApiService();
  late final AnimationController controller;
  double percent = 0;
  List<int> indices = [0, 1, 2];

  int get maxIndex => indices.length; // Your indices

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    await LocalService().getInstance();
    var token =
        await LocalService().getSavedValue(LocalDataFieldName.USER_TOKEN);
    if (token != null) {
      startNewScreen(
        ScreenType.SCREEN_WIDGET_REPLACEMENT,
        HomeScreen(),
      );
    }
  }

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'lib/assets/images/profile.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(
    String assetName, [
    double width = 180,
  ]) {
    return Image.asset(
      'lib/assets/$assetName',
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IntroductionScreen(
                key: introKey,
                globalBackgroundColor: Colors.white,
                pages: [
                  buildPageViewModel(
                    pageDecoration,
                    textPrimaryColor,
                    textSecondaryColor,
                    title: "Another title page",
                    body:
                        "Another beautiful body text for this example onboarding",
                  ),
                  PageViewModel(
                    title: "Another title page",
                    body:
                        "Another beautiful body text for this example onboarding",
                    image: _buildImage('images/note/note_orange.png'),
                    decoration: pageDecoration.copyWith(
                        bodyFlex: 6,
                        imageFlex: 6,
                        safeArea: 80,
                        titleTextStyle: TextStyle(
                          color: textPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        bodyTextStyle: TextStyle(
                          color: textSecondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                  PageViewModel(
                    title: "Another title page",
                    body:
                        "Another beautiful body text for this example onboarding",
                    image: _buildImage('images/note/note_yellow.png'),
                    decoration: pageDecoration.copyWith(
                        bodyFlex: 6,
                        imageFlex: 6,
                        safeArea: 80,
                        titleTextStyle: TextStyle(
                          color: textPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        bodyTextStyle: TextStyle(
                          color: textSecondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ],
                onDone: () => _onIntroEnd(context),
                onSkip: () => _onIntroEnd(context),
                onChange: (value) {
                  print("value $value");
                  List<double> convertToPercentage(
                      List<int> indices, int maxIndex) {
                    return indices.map((index) {
                      return (index / maxIndex) * 100;
                    }).toList();
                  }

                  List<double> percentages =
                      convertToPercentage(indices, maxIndex);
                  percent = percentages[value];
                  setState(() {});
                },
                // You can override onSkip callback
                showSkipButton: true,
                skipOrBackFlex: 0,
                nextFlex: 0,
                showBackButton: false,
                //rtl: true, // Display as right-to-left
                back: Icon(
                  Icons.arrow_back,
                  color: textPrimaryColor,
                ),
                skip: Text(
                  'Skip',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: textPrimaryColor,
                  ),
                ),
                next: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black87,
                ),
                done: Text(
                  'Ready to sing in',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: textPrimaryColor,
                  ),
                ),
                controlsMargin: const EdgeInsets.all(16),
                controlsPadding: kIsWeb
                    ? const EdgeInsets.all(12.0)
                    : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                dotsDecorator: DotsDecorator(
                  color: textSecondaryColor,
                  activeColor: textSecondaryColor,
                  activeSize: Size(16, 16),
                ),
              ),
            ),
            CustomProgressIndicator(
              value: percent,
              color: textPrimaryColor,
              controller: controller,
              width: 64,
              height: 64,
              strokeWidth: 2,
              onTab: () {},
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  PageViewModel buildPageViewModel(
    PageDecoration pageDecoration,
    Color textPrimaryColor,
    Color textSecondaryColor, {
    required String title,
    required String body,
  }) {
    return PageViewModel(
      title: title,
      body: body,
      image: _buildImage('images/note/note_back.png'),
      decoration: pageDecoration.copyWith(
          bodyFlex: 6,
          imageFlex: 6,
          safeArea: 80,
          titleTextStyle: TextStyle(
            color: textPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyTextStyle: TextStyle(
            color: textSecondaryColor,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          )),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    required this.color,
    required this.value,
    required this.controller,
    required this.width,
    required this.height,
    required this.strokeWidth,
    this.curve = Curves.linear,
    required this.onTab,
  });

  final Color color;
  final double value;
  final AnimationController controller;
  final double width;
  final double height;
  final double strokeWidth;
  final Curve curve;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            child: SizedBox(
              width: width,
              height: height,
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth,
                color: color,
                backgroundColor: color.withOpacity(.2),
                value: value,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: onTab,
              splashColor: Colors.transparent,
              radius: width * 0.8,
              child: Container(
                width: width * 0.8,
                height: height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.65),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
