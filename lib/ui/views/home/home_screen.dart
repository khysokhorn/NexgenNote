import 'package:noteapp/core/constant/general_constants.dart';
import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/model/Login/login_resposne.dart';
import 'package:noteapp/core/model/responses/user_profile_res.model.dart';
import 'package:noteapp/core/utill/app_constants.dart';
import 'package:noteapp/core/utill/colors.dart';
import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/ui/widgets/view_model_state_overlay.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StackedView<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return ViewModelStateOverlay<HomeViewModel>(
        child: Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("lib/assets/images/xbank.jpg"),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  CustomAppbar(
                    title: "X-App",
                    userRole: viewModel.userRole,
                    userProfileModel: viewModel.userProfileModel,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        await viewModel.getdataInit();
                      },
                      icon: const Icon(Icons.sync)),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: viewModel.isConnected ? Colors.green : COLOR_GRAY,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(child: viewModel.homeView[viewModel.currentIndex])
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange), label: 'Transction'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.onTabChange,
      ),
    ));
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return HomeViewModel();
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    await viewModel.getInstance();
  }
}

class CustomAppbar extends StatelessWidget {
  final String title;
  final String? userRole;
  final UserProfileModel? userProfileModel;

  const CustomAppbar(
      {super.key, required this.title, this.userRole, this.userProfileModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text(
                APP_VERSION,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 9.0),
              ),
            ),
          ],
        ),
        Text(
          "${userProfileModel?.data?.fullname ?? '-'} ($userRole)",
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class HomeView extends ViewModelWidget<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ACCENT_COLOR,
                  SECONDARY_COLOR,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Customer Collected",
                          style: TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${viewModel.dashBoard?.data.totalCollectedCount ?? 0}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Amount Collected",
                          style: TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${formatCurrency(viewModel.dashBoard?.data.collectedKhr ?? 0, Currency.khr)} KHR",
                          style: const TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${formatCurrency(viewModel.dashBoard?.data.collectedUsd ?? 0, Currency.usd)} USD",
                          style: const TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(color: Color.fromARGB(255, 255, 255, 255)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Total Customer",
                          style: TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${viewModel.totalCustomer}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Taget Collect Amount",
                          style: TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${formatCurrency(viewModel.dashBoard?.data.totalKhr ?? 0, Currency.khr)} KHR",
                          style: const TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${formatCurrency(viewModel.dashBoard?.data.totalUsd ?? 0, Currency.usd)} USD",
                          style: const TextStyle(
                            fontSize: 16,
                            color: COLOR_WHITE,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: const Row(
            children: [
              Text(
                "Recently Transction",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              //TextButton(onPressed: () {}, child: const Text("See all"))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              var data = viewModel.collectionReportModel?.data?[index];
              return Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)), // Set rounded corner radius
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Color.fromARGB(255, 225, 225, 225),
                            offset: Offset(1, 1))
                      ] // Make rounded corner of border
                      ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data?.clientNameLatin} ",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "- ${data?.clientNameKh.toString()}",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Divider(
                          color: COLOR_GRAY1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Pay :",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Total Paid :",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "REC (KHR) :",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text("REC (USD) :",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${formatNumberBaseOnCurrency(data?.totalPay, data?.loanCurrency)} ${data?.loanCurrency == "KHR" ? "៛" : "\$"}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${formatNumberBaseOnCurrency(data?.totalPaid, data?.loanCurrency)} ${data?.loanCurrency == "KHR" ? "៛" : "\$"}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  formatNumberBaseOnCurrency(
                                      data?.receiveCashKhr, data?.loanCurrency),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                    formatNumberBaseOnCurrency(
                                        data?.receiveCashUsd,
                                        data?.loanCurrency),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ));
            },
            itemCount: viewModel.collectionReportModel?.data?.length ?? 0,
          ),
        )
      ],
    );
  }
}

class MenuItemView extends StatelessWidget {
  final String title;
  final Icon icon;
  const MenuItemView({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.green),
            child: icon),
        const SizedBox(
          height: 8,
        ),
        Text(
          "$title",
          style: const TextStyle(
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
