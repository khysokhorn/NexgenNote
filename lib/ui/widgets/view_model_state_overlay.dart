import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/model/error/no_network_connection_error.dart';
import '../../core/utill/app_constants.dart';
import '../../generated/locale_keys.g.dart';

class ViewModelStateOverlay<T extends BaseViewModel>
    extends ViewModelWidget<T> {
  const ViewModelStateOverlay({
    Key? key,
    required this.child,
    this.appBarTitle,
    this.onDismissed,
    this.ignoreNoNetworkConnectionPopup,
  }) : super(key: key);

  final Widget child;
  final Function? onDismissed;
  final String? appBarTitle;
  final bool? ignoreNoNetworkConnectionPopup;

  @override
  Widget build(BuildContext context, T viewModel) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          viewModel.initialised
              ? child
              : const  Scaffold(
                  body:  Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          if (viewModel.isBusy)
            Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.dialog_processingRequest_title.tr(),
                        style: theme.bodySmall,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: const CircularProgressIndicator(),
                      ),
                      Text(
                        LocaleKeys.dialog_processingRequest_message.tr(),
                        style: theme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (viewModel.hasError &&
              ((viewModel.modelError is NoNetworkConnectionError &&
                      ignoreNoNetworkConnectionPopup == false) ||
                  viewModel.modelError is! NoNetworkConnectionError))
            GestureDetector(
              onTap: () {
                onDismissed?.call();
                viewModel.clearErrors();
                viewModel.notifyListeners();
              },
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          LocaleKeys.dialog_operationFail_title.tr(),
                          style: theme.bodyMedium!.apply(
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          color: Colors.grey[300],
                        ),
                        Text(
                          "${viewModel.modelError ?? LocaleKeys.dialog_operationFail_message.tr()}",
                          style: theme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          onPressed: () async {
                            onDismissed?.call();
                            viewModel.clearErrors();
                            viewModel.notifyListeners();
                          },
                          style: TextButton.styleFrom(),
                          child: Text(
                            onDismissed == null
                                ? LocaleKeys.button_okay.tr()
                                : LocaleKeys.button_tryAgain.tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
