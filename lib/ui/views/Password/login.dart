import 'package:noteapp/core/utill/app_constants.dart';
import 'package:noteapp/core/viewmodel/password/login_view_model.dart';
import 'package:noteapp/ui/widgets/view_model_state_overlay.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/locale_keys.g.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return ViewModelStateOverlay<LoginViewModel>(
      ignoreNoNetworkConnectionPopup: false,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                viewModel.production
                    ? const Text(
                        "",
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("UAT",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.red)),
                        ],
                      ),
                Image.asset(
                  "lib/assets/images/logo.jpg",
                  fit: BoxFit.cover,
                  width: 164,
                  height: 164,
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    TextField(
                      controller: viewModel.usreNameController,
                      style: const TextStyle(),
                      decoration: const InputDecoration(
                        hintText: "User Name",
                        suffixIcon: Icon(Icons.person_2_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: viewModel.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: viewModel.isHidden,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.web_auth_password.tr(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: viewModel.changePassword,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
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
                      await viewModel.postLogin();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Text(
                  APP_VERSION,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
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
    await viewModel.getInstance();
  }
}
