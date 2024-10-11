import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/ui/views/home/online_schedule_widget.dart';
import 'package:noteapp/ui/views/home/list_transction_offline_collected.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'list_transction_offline.dart';

class AppTransctions extends StatefulWidget {
  const AppTransctions({super.key, required this.viewModel});
  final HomeViewModel viewModel;
  @override
  State<AppTransctions> createState() => _AppTransctionsState();
}

class _AppTransctionsState extends State<AppTransctions>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var controller = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    return Column(
      children: [
        TabBar(
          controller: controller,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black,
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          tabs: const [
            Tab(
              text: "Online Schedule",
              icon: Icon(
                Icons.wifi,
              ),
            ),
            Tab(
              text: "Offline Schedule",
              icon: Icon(
                Icons.wifi_off_rounded,
              ),
            ),
            Tab(
              text: "Offline Collected",
              icon: Icon(
                Icons.receipt,
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 16,
                ),
                child: const OnlineScheduleWidget(),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 16,
                ),
                child: const OfflineSchedule(),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 16,
                ),
                child: const OfflineCollected(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
