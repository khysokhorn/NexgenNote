import 'package:noteapp/core/utill/app_constants.dart';
import 'package:noteapp/core/viewmodel/password/login_view_model.dart';
import 'package:noteapp/ui/widgets/radius_text_field.dart';
import 'package:noteapp/ui/widgets/view_model_state_overlay.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/locale_keys.g.dart';

class ChangePasswordView extends StackedView<LoginViewModel> {
  const ChangePasswordView({super.key});

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return ViewModelStateOverlay<LoginViewModel>(
      ignoreNoNetworkConnectionPopup: false,
      child: SingleChildScrollView(
        child: Form(
          key: viewModel.key,
          child: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Image.asset(
                    "lib/assets/images/logo.jpg",
                    fit: BoxFit.cover,
                    width: 164,
                    height: 164,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Column(
                    children: [
                      RadiusTextField(
                        borderWidth: 2,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textController: viewModel.passwordController,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        hintText: "Current password",
                        suffixIcon: IconButton(
                          icon: viewModel.isHidden
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: viewModel.changePassword,
                        ),
                        obscureText: viewModel.isHidden,
                        validator: (value) {
                          return value?.isEmpty == true
                              ? LocaleKeys.provideCorrectInfo.tr()
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      RadiusTextField(
                        borderWidth: 2,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textController: viewModel.newPasswordController,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        hintText: "New Password",
                        suffixIcon: IconButton(
                          icon: viewModel.newPassIsHidden
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: viewModel.newPasswordChange,
                        ),
                        obscureText: viewModel.newPassIsHidden,
                        validator: (value) {
                          return value?.isEmpty == true
                              ? LocaleKeys.provideCorrectInfo.tr()
                              : null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      RadiusTextField(
                        borderWidth: 2,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textController: viewModel.confirmPasswordController,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          icon: viewModel.confirmPasswordIsHidden
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: viewModel.confirmChangePassword,
                        ),
                        obscureText: viewModel.confirmPasswordIsHidden,
                        validator: (value) {
                          return value?.isEmpty == true
                              ? LocaleKeys.provideCorrectInfo.tr()
                              : (value ==
                                      viewModel.newPasswordController.text
                                          .trim()
                                  ? null
                                  : "Password not match.");
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: const Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text("Change language"),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    child: MaterialButton(
                      textColor: Colors.white,
                      padding: EdgeInsets.all(12),
                      color: Colors.green,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      onPressed: () async {
                        await viewModel.setNewPassword();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          LocaleKeys.settings_changePassword.tr(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: const Text(
                      APP_VERSION,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 12.0),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
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
    viewModel.isChangePassword = true;
    await viewModel.getInstance();
  }
}
