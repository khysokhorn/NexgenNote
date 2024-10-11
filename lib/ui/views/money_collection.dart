import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart'
    as laonList;
import 'package:noteapp/core/utill/app_constants.dart';
import 'package:noteapp/core/utill/colors.dart';
import 'package:noteapp/core/utill/dimensions.dart';
import 'package:noteapp/core/utill/regexes.dart';
import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/core/viewmodel/money_collection_viewmodel.dart';
import 'package:noteapp/generated/locale_keys.g.dart';
import 'package:noteapp/ui/views/home/home_screen.dart';
import 'package:noteapp/ui/widgets/radius_text_field.dart';
import 'package:noteapp/ui/widgets/view_model_state_overlay.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';

import '../../core/model/responses/loan_schedule_res.model.dart';
import '../widgets/form_row2_widget.dart';
import '../widgets/form_text_input_widget.dart';

class MoneyCollection extends StackedView<MoneyCollectionViewModel> {
  final laonList.Datum? loanSchedule;
  final LoanScheduleListModel? allLoanItems;
  final DraftCustomerListViewController? draftCustomerListPageController;

  const MoneyCollection(this.loanSchedule, this.allLoanItems,
      {super.key, this.draftCustomerListPageController});

  _formTextViewItemWidget({
    required String title,
    String? text,
    bool? hasPaddingTop,
    bool? hasPaddingBottom,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasPaddingTop == true)
          const SizedBox(
            height: 16,
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            title.toUpperCase(),
            style:
                theme.bodySmall!.copyWith(color: COLOR_GRAY, letterSpacing: 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            text == null || text.isEmpty ? "" : text,
            style: theme.bodyMedium!.copyWith(color: COLOR_BLACK),
          ),
        ),
        if (hasPaddingBottom == true)
          const SizedBox(
            height: 30,
          ),
      ],
    );
  }

  _lableTextView(String text, double fontSize, bool bold, bool capital) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(capital ? text.toUpperCase() : text,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: bold ? FontWeight.w500 : FontWeight.w400)),
    );
  }

  depositAmount(TextEditingController depositAmountCtl, String lable,
      {TextInputType inputType = TextInputType.number,
      int maxLine = 1,
      String? Function(String?)? validator}) {
    return RadiusTextField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      //focusNode: viewModel.depositAmountFocus,
      textInputType: inputType,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExes.amount),
        DecimalFormatter()
      ],
      borderColor: COLOR_GRAY,
      backgroundColor: COLOR_WHITE,
      textController: depositAmountCtl,
      fillColor: Colors.white,
      hintText: lable.toUpperCase(),
      labelColor: COLOR_GRAY,
      textColor: COLOR_BLACK,
      fontSize: 14,
      maxLength: 18,
      contentPadding: const EdgeInsets.all(12.0),
      // onChanged: viewModel.convertAmount,
      maxLine: maxLine,
      validator: validator,
    );
  }

  @override
  Widget builder(
      BuildContext context, MoneyCollectionViewModel viewModel, Widget? child) {
    return ViewModelStateOverlay<MoneyCollectionViewModel>(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              CustomAppbar(
                title: "Money Collection",
                userRole: viewModel.userRole,
                userProfileModel: viewModel.userProfileModel,
              ),
              const Divider(
                thickness: 0.09,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 14.0),
                          child: Text(
                            "Client Information",
                            style: TextStyle(
                                color: COLOR_BLACK,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 15.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _lableTextView('Khmer Name', 15, false, false),
                                _lableTextView('Latin Name', 15, false, false),
                                _lableTextView(
                                    'Phone Number', 15, false, false),
                                _lableTextView(
                                    'Village Name', 15, false, false),
                              ],
                            ),
                            const SizedBox(width: 25.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _lableTextView(
                                    ': ${loanSchedule?.clientNameKh}',
                                    15,
                                    true,
                                    false),
                                _lableTextView(
                                    ': ${loanSchedule?.clientNameLatin}',
                                    15,
                                    true,
                                    false),
                                _lableTextView(': ${loanSchedule?.clientPhone}',
                                    15, true, false),
                                _lableTextView(': ${loanSchedule?.villageName}',
                                    15, true, false),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 14, bottom: 14.0),
                                      child: Text(
                                        "Repayment Information",
                                        style: TextStyle(
                                            color: COLOR_BLACK,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 15.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _lableTextView('Loan Outstanding',
                                                15, false, false),
                                            _lableTextView('Installment No', 15,
                                                false, false),
                                            _lableTextView(
                                                'Interest', 15, false, false),
                                            _lableTextView(
                                                'Principle', 15, false, false),
                                            _lableTextView('Operation Fee', 15,
                                                false, false),
                                            _lableTextView('Loan Currency', 15,
                                                false, false),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Total Pay",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 25.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _lableTextView(
                                                ': ${formatNumberBaseOnCurrency(loanSchedule?.outstandingBalance, loanSchedule?.loanCurrency)}',
                                                15,
                                                true,
                                                false),
                                            _lableTextView(
                                                ": ${loanSchedule?.instalmentPay} - ${loanSchedule?.repaymentFreq}",
                                                15,
                                                true,
                                                false),
                                            _lableTextView(
                                                ": ${formatNumberBaseOnCurrency(loanSchedule?.interestAmt, loanSchedule?.loanCurrency)}",
                                                15,
                                                true,
                                                false),
                                            _lableTextView(
                                                ": ${formatNumberBaseOnCurrency(loanSchedule?.principleAmt, loanSchedule?.loanCurrency)}",
                                                15,
                                                true,
                                                false),
                                            _lableTextView(
                                                ": ${formatNumberBaseOnCurrency(loanSchedule?.operationFeeAmount, loanSchedule?.loanCurrency)}",
                                                15,
                                                true,
                                                false),
                                            _lableTextView(
                                                ": ${loanSchedule?.loanCurrency}",
                                                15,
                                                true,
                                                false),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                ": ${formatNumberBaseOnCurrency(loanSchedule?.totalPay, loanSchedule?.loanCurrency)}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        FormInputAmount(
                          loanSchedule: loanSchedule,
                          viewModel: viewModel,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(PRIMARY_COLOR),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(16)), // Remove padding
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                    ),
                    minimumSize: MaterialStateProperty.all(
                        const Size(0, 0)), // Remove minimum size
                  ),
                  onPressed: () async {
                    // showOptionSelectionDialog(
                    //   title: "Confimed Payment",
                    //   contentMsg: "Do you wanted to make payment on this client?",
                    //   onConfirmPress: await viewModel.submitLoan()
                    //   );
                    String totalPaid = viewModel.totalPaidController.text;
                    String receiveCashKhr = viewModel.recKHRController.text;
                    String receiveCashUSD = viewModel.recUSDController.text;
                    if (receiveCashUSD == "") {
                      receiveCashUSD = "0";
                    }
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Payment'),
                          content: SizedBox(
                              height: 70,
                              child: Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Paid: ",
                                          style: TextStyle(
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT,
                                          )),
                                      Text("Received KHR: ",
                                          style: TextStyle(
                                              fontSize: Dimensions
                                                  .FONT_SIZE_DEFAULT)),
                                      Text("Received USD: ",
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT))
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        totalPaid,
                                        style: const TextStyle(
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        receiveCashKhr,
                                        style: const TextStyle(
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        receiveCashUSD,
                                        style: const TextStyle(
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Yes'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await viewModel.submitLoan();
                                // ignore: use_build_context_synchronously
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  MoneyCollectionViewModel viewModelBuilder(BuildContext context) {
    return MoneyCollectionViewModel(
      draftCustomerListPageController: draftCustomerListPageController,
    );
  }

  @override
  void onViewModelReady(MoneyCollectionViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    await viewModel.getInstance(loanSchedule, allLoanItems);
  }
}

class FormInputAmount extends StatelessWidget {
  const FormInputAmount({
    super.key,
    required this.loanSchedule,
    required this.viewModel,
  });
  final MoneyCollectionViewModel viewModel;
  final laonList.Datum? loanSchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: viewModel.formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 8.0, top: 12.0, right: 8.0),
            child: Column(
              children: [
                FormRow2Widget(
                  children: [
                    FormTextInputWidget(
                      textController: viewModel.totalPaidController,
                      textInputType: TextInputType.number,
                      hintText: "Total Paid (${loanSchedule?.loanCurrency})",
                      inputFormatters: [
                        loanSchedule?.loanCurrency == "USD"
                            ? FilteringTextInputFormatter.allow(
                                RegExes.currencyUSD)
                            : FilteringTextInputFormatter.allow(RegExes.amount),
                        DecimalFormatter()
                      ],
                      maxLength: 35,
                      validator: viewModel.totalPaidValidator,
                    ),
                  ],
                ),
                FormRow2Widget(
                  children: [
                    FormTextInputWidget(
                      textController: viewModel.recKHRController,
                      textInputType: TextInputType.number,
                      hintText: "REC (KHR)",
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExes.amountKHR),
                        DecimalFormatter()
                      ],
                      maxLength: 35,
                      validator: viewModel.validator,
                    ),
                    FormTextInputWidget(
                      textController: viewModel.recUSDController,
                      textInputType: TextInputType.number,
                      hintText: "REC (USD)",
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExes.amount),
                        DecimalFormatter()
                      ],
                      maxLength: 35,
                      validator: viewModel.validator,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black26,
                ),
              ),
              child: TextFormField(
                minLines: 4,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                controller: viewModel.remarkController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Remark',
                  focusedBorder: InputBorder.none,
                  prefixIcon: SizedBox(
                    width: 20,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.topic_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.provideCorrectInfo.tr();
                  }
                  return null;
                },
              )),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class DecimalFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalFormatter({this.decimalDigits = 2})
      : assert(decimalDigits >= 0 || decimalDigits <= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText;

    if (decimalDigits == 0) {
      newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    } else {
      newText = newValue.text.replaceAll(RegExp('[^0-9\.-]'), '');
    }

    if (newText.contains('.')) {
      //in case if user's first input is "."
      if (newText.trim() == '.') {
        return newValue.copyWith(
          text: '0.',
          selection: const TextSelection.collapsed(offset: 2),
        );
      }
      //in case if user tries to input multiple "."s or tries to input
      //more than the decimal place
      else if ((newText.split(".").length > 2) ||
          (newText.split(".")[1].length > this.decimalDigits)) {
        return oldValue;
      } else
        return newValue;
    }

    //in case if input is empty or zero
    if (newText.trim() == '' || newText.trim() == '0') {
      return newValue.copyWith(text: '');
    }
    // else if (int.parse(newText) < 1) {
    //   return newValue.copyWith(text: '');
    // }

    double newDouble = double.parse(newText);
    var selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    String newString = NumberFormat("#,##0.##").format(newDouble);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
