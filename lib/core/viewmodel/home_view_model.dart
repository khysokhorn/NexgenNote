import 'dart:async';

import 'package:noteapp/core/enums/local_service.dart';
import 'package:noteapp/core/enums/screen_type.dart';
import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/model/request/collection_report_req.model.dart';
import 'package:noteapp/core/model/request/loan_schedule_req.model.dart';
import 'package:noteapp/core/model/request/post_loan_collection.dart';
import 'package:noteapp/core/model/responses/DashboardResponseModel.dart';
import 'package:noteapp/core/model/responses/collection_report_res.model.dart'
    as collectLoan;
import 'package:noteapp/core/model/responses/dashboard_home_res.model.dart'
    as dashboardHomeModel;
import 'package:noteapp/core/model/responses/json_place_holder.dart';

// import 'package:noteapp/core/modschedule_res.model.dart' as laonList;
import 'package:noteapp/core/model/responses/setting_res.model.dart';
import 'package:noteapp/core/model/responses/user_profile_res.model.dart';
import 'package:noteapp/core/services/api_provider_service.dart';
import 'package:noteapp/core/services/global_service.dart';
import 'package:noteapp/core/services/local_service.dart';
import 'package:noteapp/core/web_service/api_provider_service.web.dart';
import 'package:noteapp/ui/views/home/app_transction.dart';
import 'package:noteapp/ui/views/home/home_screen.dart';
import 'package:noteapp/ui/views/Password/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/v1.dart';
import '../model/responses/loan_schedule_res.model.dart';
import '../services/network_info_service.dart';

class HomeViewModel extends BaseViewModel {
  var currentIndex = 0;
  DraftCustomerListViewController draftCustomerListPageController =
      DraftCustomerListViewController();
  final ScrollController scrollController = ScrollController();
  TextEditingController searchValue = TextEditingController();
  TextEditingController searchValueOffline = TextEditingController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int pageNumber = 0;
  final int pageSize = 10;
  int? totalPage;
  int? totalFoundResults = 0;
  String? userRole = '';
  UserProfileModel? userProfileModel;
  List<JsonPlaceHolderModel> movies = [];
  var homeView = [];
  StreamSubscription<ConnectivityResult>? _connectivityChangeListener = null;

  LoanScheduleListModel? dataSource;
  LoanScheduleListModel? refreshdDataSource;
  LoanScheduleListModel? storeDataSource;
  LoanScheduleListModel? dataSourceOffline;
  LoanScheduleListModel? refreshDataSourceOffline;
  LoanScheduleListModel? storeDataSourceOffline;

  collectLoan.CollectionReportModel? collectionReportModel;

  SettingModel? settingData;

  DashboardResponseOCRModel? dashBoard;
  int totalCustomer = 0;

  bool isConnected = true;

  PostLoanCollectionLocalLists? offLineSubmit;

  Future<void> getInstance() async {
    clearErrors();
    setInitialised(true);
    notifyListeners();
    await LocalService().getInstance();
    setBusy(false);
  }

  Future<void> getdataInit() async {
    setBusy(true);
    userRole = await LocalService().getSavedValue(LocalDataFieldName.USER_ROLE);
    await checkConnectivityStatus();
    if (isConnected) {
      await online();
    } else {
      await getLoanScheduleListOffLine();
    }
    _connectivityChangeListener =
        NetworkInfoService().addListener(((connection) async {
      await _onConnectivityChanged(connection);
    }));
    draftCustomerListPageController.setReloadListener(() async {
      if (isConnected) {
        setBusy(true);
        notifyListeners();
        await getLoanScheduleList();
        await getLoanCollection();
        setBusy(false);
        notifyListeners();
      } else {
        await getLoanScheduleListOffLine();
        await getOffLineCollected();
      }
    });
    setBusy(false);
    notifyListeners();
  }

  online() async {
    await getUserProfile();
    await getLoanScheduleList();
    await getLoanCollection();
    await getSetting();
    await getDashboard();
  }

  void onTabChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  getUserProfile() async {
    try {
      var a = ApiProviderService().getRestClient();
      UserProfileModel response = await a.getUserProfile();
      userProfileModel = response;
      await LocalService().getInstance();
      await LocalService().saveValue(
          LocalDataFieldName.USER_PROFILE, userProfileModelToJson(response));
      notifyListeners();
      setBusy(false);
    } catch (e) {
      print("Error with $e");
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
    }
  }

  Future getLoanCollection(
      {Filter? filter, int pageNumber = 1, int pageSize = 1000}) async {
    try {
      CollectionReportReqModel filterBody = CollectionReportReqModel(
        requestId: const UuidV1().generate(),
        pageNumber: pageNumber,
        pageSize: pageSize,
        filter: filter ??
            Filter(
                loanAccount: "",
                clientName: "",
                branchId: userProfileModel?.data?.branchId,
                companyId: userProfileModel?.data?.companyId,
                villageId: "ALL",
                employeeId: userProfileModel?.data?.objectId,
                fromDate: GlobalFunction.getCurrentDateYYYYMMDD(),
                toDate: GlobalFunction.getCurrentDateYYYYMMDD(),
                status: "Posted"),
      );
      var response = await ApiProviderService()
          .getRestClient()
          .getCollectionReport(filterBody);
      collectionReportModel =
          collectLoan.CollectionReportModel(data: response.data ?? []);
      notifyListeners();
    } catch (e) {
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
    }
  }

  Future getSetting() async {
    var response = await ApiProviderService().getRestClient().getSettings();
    settingData = response;
    notifyListeners();
  }

  getDashboard() async {
    dashBoard =
        await ApiProviderService().getRestClient().getDashboardOCRHome();
    if (dashBoard!.data.totalCollectedCount != null ||
        dashBoard!.data.totalPendingCollectCount != null) {
      totalCustomer = int.parse(dashBoard!.data.totalCollectedCount!) +
          int.parse(dashBoard!.data.totalPendingCollectCount!);
    }
    notifyListeners();
  }

  Future getLoanScheduleList(
      {Filter? filter, int pageNumber = 1, int pageSize = 1000}) async {
    LoanScheduleReqModel filterBody = LoanScheduleReqModel(
      requestId: const UuidV1().generate(),
      pageNumber: pageNumber,
      pageSize: pageSize,
      filter: filter ??
          Filter(
            loanAccount: "",
            clientName: "",
            branchId: userProfileModel?.data?.branchId,
            villageId: "ALL",
            companyId: userProfileModel?.data?.companyId ?? '',
            employeeId: userProfileModel?.data?.objectId,
            status: "Pending",
          ),
    );
    var response = await ApiProviderService()
        .getRestClient()
        .getLoanScheduleList(filterBody);
    dataSource = LoanScheduleListModel(data: response.data ?? []);
    refreshdDataSource = LoanScheduleListModel(data: response.data ?? []);
    storeDataSource = LoanScheduleListModel(data: response.data ?? []);
    await LocalService()
        .deleteSavedValue(LocalDataFieldName.LAON_SCHEDULE_OFFLINE);
    await LocalService().saveValue(LocalDataFieldName.LAON_SCHEDULE_OFFLINE,
        loanScheduleListModelToJson(response));
    notifyListeners();
  }

  searchCustomerInListview(String customerName) {
    clearErrors();
    // notifyListeners();
    if (customerName.isEmpty || customerName == '') {
      refreshdDataSource = storeDataSource;
    } else {
      refreshdDataSource?.data = dataSource?.data
          ?.where((loanlist) => loanlist.clientNameLatin
              .toLowerCase()
              .contains(customerName.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  searchCustomerInListviewOffline(String customerName) {
    clearErrors();
    // notifyListeners();
    if (customerName.isEmpty || customerName == '') {
      refreshDataSourceOffline = storeDataSourceOffline;
    } else {
      refreshDataSourceOffline?.data = dataSourceOffline?.data
          ?.where((loanlist) => loanlist.clientNameLatin
              .toLowerCase()
              .contains(customerName.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // get Loan Schedue offline
  Future getLoanScheduleListOffLine(
      {Filter? filter, int pageNumber = 1, int pageSize = 1000}) async {
    dataSource?.data?.clear();
    String d = await LocalService()
        .getSavedValue(LocalDataFieldName.LAON_SCHEDULE_OFFLINE);
    dataSourceOffline = loanScheduleListModelFromJson(d);
    refreshDataSourceOffline = loanScheduleListModelFromJson(d);
    storeDataSourceOffline = loanScheduleListModelFromJson(d);
    notifyListeners();
  }

  checkConnectivityStatus() async {
    isConnected = await NetworkInfoService().isConnected;
    //setBusy(true);
    notifyListeners();
    await getOffLineCollected();
    if (isConnected) {
      await syncQueuedDataToServerOffline();
    } else {
      userProfileModel = userProfileModelFromJson(
          await LocalService().getSavedValue(LocalDataFieldName.USER_PROFILE));
      //await getLoanScheduleListOffLine();
    }
    //setBusy(false);
    notifyListeners();
  }

  _onConnectivityChanged(bool isConnected) async {
    this.isConnected = isConnected;
    //dataSourceOffline?.data?.clear();
    setBusy(true);
    notifyListeners();
    if (this.isConnected) {
      dataSource?.data?.clear();
      dataSourceOffline?.data?.clear();
      refreshDataSourceOffline?.data?.clear();
      storeDataSourceOffline?.data?.clear();
      collectionReportModel?.data?.clear();
      await online();
    } else {
      await getLoanScheduleListOffLine();
      await getOffLineCollected();
    }
    setBusy(false);
    notifyListeners();
  }

  PostLoanCollectionLocalLists? data;

  Future<void> syncQueuedDataToServerOffline() async {
    if (isConnected) {
      data = postLoanCollectionModelLocalFromJson(await LocalService()
              .getSavedValue(LocalDataFieldName.LOAN_COLLECTION_SUBMIT) ??
          "{}");
      if (data?.data?.isNotEmpty == true) {
        setBusy(true);
        notifyListeners();
        data?.data?.toSet().forEach((element) async {
          try {
            await ApiProviderService().getRestClient().postLoanSubmit(element);
            data?.data?.remove(element);
            await LocalService().saveValue(
              LocalDataFieldName.LOAN_COLLECTION_SUBMIT,
              postLoanCollectionModelLocalToJson(data!),
            );
          } catch (e) {
            GlobalFunction.printDebugMessage(e);
            GlobalFunction.onHttpRequestFail(e, this);
            setBusy(false);
            notifyListeners();
          } finally {
            setBusy(false);
            notifyListeners();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _connectivityChangeListener?.cancel();
  }

  getOffLineCollected() async {
    offLineSubmit = postLoanCollectionModelLocalFromJson(await LocalService()
            .getSavedValue(LocalDataFieldName.LOAN_COLLECTION_SUBMIT) ??
        "{}");
    offLineSubmit?.data = offLineSubmit?.data?.toSet().toList();
  }
}

class DraftCustomerListViewController {
  VoidCallback? _reloadListener;

  setReloadListener(VoidCallback? listener) {
    _reloadListener = listener;
  }

  void reload() {
    _reloadListener?.call();
  }
}
