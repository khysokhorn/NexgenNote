import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:noteapp/core/constant/general_constants.dart';
import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/model/responses/user_profile_res.model.dart';
import 'package:noteapp/core/utill/app_constants.dart';
import 'package:noteapp/core/utill/colors.dart';
import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/ui/widgets/alert_dialog.dart';
import 'package:noteapp/ui/widgets/notification_snackbar.dart';
import 'package:noteapp/ui/widgets/primary_button.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:stacked/stacked.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _tabName = ["hello", "Test"];
  int currentPage = 0;
  double tabBarHeight = 80.0;
  late TabController tabController;
  late AnimationController _hideTabBarAnimationController;
  late Animation<double> _offsetAnimation;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> _borderRadiusAnimation;
  final List<String> tabNames = [
    'Today Expend',
    'Summary',
  ];

  final List<Widget> _kTabPages = <Widget>[Container(), Container()];
  final _controller = SideMenuController();
  int _currentIndex = 0;
  final String currencyCategory = 'KHR';

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabNames.length,
      vsync: this,
    );

    _hideTabBarAnimationController = AnimationController(
      duration: duration,
      vsync: this,
    );
    _offsetAnimation = Tween(begin: 0.0, end: tabBarHeight)
        .animate(_hideTabBarAnimationController)
      ..addListener(() {
        setState(() {});
      });
    _borderRadiusAnimationController = AnimationController(
      duration: duration,
      vsync: this,
    );
    _borderRadiusAnimation =
        Tween(begin: 128.0, end: 0.0).animate(_borderRadiusAnimationController)
          ..addListener(() {
            setState(() {});
          });
    tabController = TabController(
      length: tabNames.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _hideTabBarAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortraitOrientation =
        MediaQuery.orientationOf(context) == Orientation.portrait;

    final List<Widget> tabIcons = [
      Icon(HugeIcons.strokeRoundedBitcoinEye),
      Icon(HugeIcons.strokeRoundedDashboardBrowsing),
      AnimatedContainer(
        duration: duration,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: scaffoldBgColor,
            width: 1.5,
          ),
        ),
        child: CircleAvatar(
          radius: 16.0,
          backgroundColor: seedColorPalette.shade700,
          backgroundImage: AssetImage('lib/assets/images/note/note_orange.png'),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Expend"),
        actions: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orangeAccent,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              style: const ButtonStyle(),
            ),
          ),
          SizedBox(
            width: 24,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.attach_money_outlined,
                                color: Colors.grey,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textPrimaryColor, width: .1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomLeft: Radius.circular(24)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textPrimaryColor, width: .1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomLeft: Radius.circular(24)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomLeft: Radius.circular(24)),
                              ),
                              // A
                              hintText: 'Enter Amount',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textSecondaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                iconEnabledColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                dropdownColor: textPrimaryColor,
                                value: currencyCategory,
                                items: ['USD', 'KHR']
                                    .map((String value) => DropdownMenuItem(
                                          value: value,
                                          child: Row(
                                            children: <Widget>[
                                              Text(value),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: textPrimaryColor, width: .1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: textPrimaryColor, width: .1),
                      ),
                      border: OutlineInputBorder(), // A
                      hintText: 'Mobile Number',
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class IconBottomItem extends StatelessWidget {
  const IconBottomItem({
    super.key,
    required this.icon,
  });

  final HugeIcon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      alignment: AlignmentDirectional.center,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(
        onPressed: () {},
        icon: icon,
      ),
    );
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

class TabBuilder extends StatelessWidget {
  const TabBuilder({
    super.key,
    required this.icon,
    required this.title,
    required this.currentIndex,
    required this.index,
  });

  final Widget icon;
  final String title;
  final int index, currentIndex;

  @override
  Widget build(BuildContext context) {
    if (index == currentIndex) {
      // Community tab
      if (index == 1) {
        return PieMenu(
          onPressed: () {
            // show flutter toast
            Fluttertoast.showToast(
              msg: "Long press for options",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: disabledColor.withOpacity(0.8),
              textColor: scaffoldBgColor,
              fontSize: 16.0,
            );
          },
          onToggle: (menuOpen) {
            if (menuOpen) {
              HapticFeedback.lightImpact();
            }
          },
          actions: [
            PieAction(
              tooltip: const Text('Submit procedure'),
              onSelect: () {
                showNotificationSnackBar(
                  context: context,
                  backgroundColor: successColor,
                  icon: successIcon,
                  message: "Submit procedure selected successfully",
                );
              },
              child: const Icon(HugeIcons.strokeRoundedSent),
            ),
            PieAction(
              tooltip: const Text('Request procedure'),
              onSelect: () {
                showNotificationSnackBar(
                  context: context,
                  backgroundColor: successColor,
                  icon: successIcon,
                  message: "Request procedure selected successfully",
                );
              },
              child: const Icon(HugeIcons.strokeRoundedIdea),
            ),
          ],
          child: Animate(
            effects: [
              FadeEffect(),
            ],
            child: Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  const Gap(8.0),
                  Text(
                    title,
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Tooltip(
        message: title,
        child: Tab(
          child: Animate(
            effects: [
              FadeEffect(),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                Gap(8.0),
                Text(
                  title,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Tooltip(
      message: title,
      child: Tab(
        child: Row(
          children: [
            icon,
            Gap(8.0),
            Text(
              title,
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }
}
