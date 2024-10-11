import 'dart:async';
import 'dart:ui';

import 'package:noteapp/core/enums/local_service.dart';
import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/model/request/post_loan_collection.dart';
import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart'
    as laonList;
import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart';
import 'package:noteapp/core/model/responses/user_profile_res.model.dart';
import 'package:noteapp/core/services/api_provider_service.dart';
import 'package:noteapp/core/services/global_service.dart';
import 'package:noteapp/core/services/local_service.dart';
import 'package:noteapp/core/services/network_info_service.dart';
import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/generated/locale_keys.g.dart';
import 'package:noteapp/utill/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class MoneyCollectionViewModel extends BaseViewModel {
  TextEditingController remarkController = TextEditingController();
  TextEditingController recKHRController = TextEditingController();
  TextEditingController recUSDController = TextEditingController();
  TextEditingController totalPaidController = TextEditingController();
  final DraftCustomerListViewController? draftCustomerListPageController;
  HomeViewModel homeViewMode = HomeViewModel();
  final formKey = GlobalKey<FormState>();
  laonList.Datum? loanSchedule;
  LoanScheduleListModel? allLoanItems;
  UserProfileModel? userProfileModel;
  bool isConnected = true;
  String? userRole;
  StreamSubscription<ConnectivityResult>? _connectivityChangeListener;

  MoneyCollectionViewModel({required this.draftCustomerListPageController});

  getInstance(laonList.Datum? data, LoanScheduleListModel? allLoanItems) async {
    setInitialised(true);
    clearErrors();
    setBusy(true);
    notifyListeners();
    loanSchedule = data;
    this.allLoanItems = allLoanItems;
    await checkConnectivityStatus();
    await LocalService().getInstance();
    var a = await LocalService().getSavedValue(LocalDataFieldName.USER_PROFILE);
    userProfileModel = userProfileModelFromJson(a);
    _connectivityChangeListener =
        NetworkInfoService().addListener(((connection) async {
      await _onConnectivityChanged(connection);
    }));
    userRole = await LocalService().getSavedValue(LocalDataFieldName.USER_ROLE);
    notifyListeners();
    setBusy(false);
  }

  submitLoan() async {
    setBusy(true);
    try {
      var a = ApiProviderService().getRestClient();
      var receiveCashKhr =
          double.tryParse(recKHRController.text.replaceAll(',', ''));
      var receiveCashUSD =
          double.tryParse(recUSDController.text.replaceAll(",", ''));
      var totalPaid =
          double.tryParse(totalPaidController.text.replaceAll(",", ''));
      var remark = remarkController.text;
      var bodyRequst = PostLoanCollection().converter(loanSchedule,
          userProfileModel, receiveCashKhr, receiveCashUSD, totalPaid, remark);
      //bodyRequst.printJson();
      if (formKey.currentState?.validate() == true) {
        if (isConnected) {
          var response = await a.postLoanSubmit(bodyRequst);
          if (response.status) {
            showAlert(
              message: "Loan submit successful.",
              title: "Operation success",
              titleColor: PRIMARY_COLOR,
              buttonTitle: "OK",
              onPress: () {
                Navigator.of(GlobalService().context).pop();
                draftCustomerListPageController?.reload();
              },
            );
          }
        } else {
          await saveCollectionOffLine(bodyRequst);
          // show confirm dialog save complet in local.
          showAlert(
            message: "Loan submit successful in your mobile.",
            title: "Operation success",
            titleColor: PRIMARY_COLOR,
            onPress: () {
              Navigator.of(GlobalService().context).pop();
              draftCustomerListPageController?.reload();
            },
            buttonTitle: "OK",
          );
        }
      }
    } catch (e) {
      print("Error with $e");
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
    }
    notifyListeners();
    setBusy(false);
  }

  checkConnectivityStatus() async {
    isConnected = await NetworkInfoService().isConnected;
    notifyListeners();
    if (isConnected) {
    } else {}
  }

  _onConnectivityChanged(bool isConnected) async {
    this.isConnected = isConnected;
    setBusy(true);
    if (this.isConnected) {
    } else {}
    setBusy(false);
    notifyListeners();
  }

  Future<void> saveCollectionOffLine(
      PostLoanCollection postLoanCollection) async {
    clearErrors();
    PostLoanCollectionLocalLists offLineSubmit =
        postLoanCollectionModelLocalFromJson(await LocalService()
                .getSavedValue(LocalDataFieldName.LOAN_COLLECTION_SUBMIT) ??
            "{}");
    offLineSubmit.data?.add(postLoanCollection);
    await LocalService().saveValue(LocalDataFieldName.LOAN_COLLECTION_SUBMIT,
        postLoanCollectionModelLocalToJson(offLineSubmit));
    // update item status
    String? d = await LocalService()
        .getSavedValue(LocalDataFieldName.LAON_SCHEDULE_OFFLINE);
    var dataSourceOffline = loanScheduleListModelFromJson(d!);
    try {
      var itemObjectId = postLoanCollection.requestDataJson?['objectID'];
      dataSourceOffline.data
          ?.removeWhere((element) => element.objectId == itemObjectId);

      /// await LocalService().deleteSavedValue(LocalDataFieldName.LAON_SCHEDULE_OFFLINE);
      await LocalService().saveValue(LocalDataFieldName.LAON_SCHEDULE_OFFLINE,
          loanScheduleListModelToJson(dataSourceOffline));
      homeViewMode.getLoanScheduleListOffLine();
    } catch (e) {
      print("error $e");
    }
    //notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivityChangeListener?.cancel();
  }

  String? validator(String? value) {
    var usdAmount = recUSDController.text;
    if (recKHRController.text.isEmpty && usdAmount.isEmpty) {
      return LocaleKeys.provideCorrectInfo.tr();
    }
    return null;
  }

  String? totalPaidValidator(String? value) {
    if (totalPaidController.text.isEmpty) {
      return LocaleKeys.provideCorrectInfo.tr();
    }
    return null;
  }
}
