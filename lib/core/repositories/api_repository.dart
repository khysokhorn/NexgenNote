import 'dart:io';

import 'package:noteapp/core/model/Login/login_request.dart';
import 'package:noteapp/core/model/Login/login_resposne.dart';
import 'package:noteapp/core/model/request/collection_report_req.model.dart';
import 'package:noteapp/core/model/request/loan_schedule_req.model.dart';
import 'package:noteapp/core/model/request/post_loan_collection.dart';
import 'package:noteapp/core/model/request/post_status_req.model.dart';
import 'package:noteapp/core/model/request/user_auth_req.model.dart';
import 'package:noteapp/core/model/responses/DashboardResponseModel.dart';
import 'package:noteapp/core/model/responses/Mobile/base_response.dart';
import 'package:noteapp/core/model/responses/collection_report_res.model.dart';
import 'package:noteapp/core/model/responses/dashboard_home_res.model.dart';
import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart';
import 'package:noteapp/core/model/responses/money_collection/post_loan_schedule_response.dart';
import 'package:noteapp/core/model/responses/post_status_res.model.dart';
import 'package:noteapp/core/model/responses/setting/app_version_model.dart';
import 'package:noteapp/core/model/responses/setting_res.model.dart';
import 'package:noteapp/core/model/responses/user_auth_res.model.dart';
import 'package:noteapp/core/model/responses/user_profile_res.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/request/Password/request_new_password.dart';
import '../model/responses/json_place_holder.dart';
import '../utill/app_constants.dart';

part 'api_repository.g.dart';

@RestApi(baseUrl: BASE_API_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  @GET('posts')
  Future<List<JsonPlaceHolderModel>> getAllMovie();

  @POST("login")
  Future<LoginResponse> postLogin(@Body() LoginRequest loginRequest);

  @POST('login')
  Future<UserAuthModel> login(@Body() UserAuthReqModel body);

  @GET('dashboard/get-overall-staff-collection')
  Future<DashboardHomeModel> getDashboardHome();

  @GET('login/get-user-profile')
  Future<UserProfileModel> getUserProfile();

  /// Collection Report
  @POST('loan-repayment-history/search-list')
  Future<CollectionReportModel> getCollectionReport(
      @Body() CollectionReportReqModel body);

  /// Loan Schedule
  @POST('loan-repayment/search-list')
  Future<LoanScheduleListModel> getLoanScheduleList(
      @Body() LoanScheduleReqModel body);

  @GET('setting')
  Future<SettingModel> getSettings();

  @POST("loan-repayment/upload")
  @MultiPart()
  Future<LoanScheduleListModel> uploadFile(
      @Part(name: "FileUpload") List<MultipartFile> files);

  @POST("loan-repayment-history")
  Future<PostLoanScheduleResponse> postLoanSubmit(
      @Body() PostLoanCollection loginRequest);

  @GET('dashboard/get-ocr-collection-balance')
  Future<DashboardResponseOCRModel> getDashboardOCRHome();

  @PUT('loan-repayment-history/{id}')
  Future<PostStatusResModel> updatePostStatus(
      @Path("id") String postStatusId, @Body() PostStatusReqModel body);

  @POST('login/request-change-password')
  Future<BaseResponse<String>> changePassword(@Body() RequestNewPassword body);

  @GET('app-version')
  Future<AppVersionModel> getAppVersion();
}
