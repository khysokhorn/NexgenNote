import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utill/app_constants.dart';
import '../../core/utill/colors.dart';
import '../../generated/locale_keys.g.dart';

class NoNetworkConnectionViewWidget extends StatelessWidget {
  final String? title;
  final String? message;

  const NoNetworkConnectionViewWidget({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 42,
            ),
            const Icon(
              Icons.cloud_off_outlined,
              size: 100,
              color: COLOR_GREY,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              title ?? LocaleKeys.text_noNetworkConnection.tr(),
              style: theme.headlineSmall,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              message ?? LocaleKeys.text_reconnectAndRetry.tr(),
              style: theme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
