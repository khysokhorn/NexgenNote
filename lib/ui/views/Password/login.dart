import 'package:noteapp/core/constant/general_constants.dart';
import 'package:noteapp/core/viewmodel/password/login_view_model.dart';
import 'package:noteapp/ui/views/home/home_screen.dart';
import 'package:noteapp/ui/widgets/view_model_state_overlay.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return ViewModelStateOverlay<LoginViewModel>(
      ignoreNoNetworkConnectionPopup: false,
      child: Padding(
        // decoration: const BoxDecoration(color: Colors.transparent),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            Container(
              margin: EdgeInsets.all(32),
              child: Image.asset('lib/assets/images/note/gmail.png'),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: textSecondaryColor,
                  )),
              child: const Text(
                  'Another beautiful body text for this example onboarding'),
            ),
            const Spacer(),
            SocialLoginButton(
              buttonType: SocialLoginButtonType.google,
              onPressed: () async {
                await viewModel.handleSignIn();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) {
    return LoginViewModel();
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) async {
    await viewModel.getInstance();
  }
}
