import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart'
    as laonList;
import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart';
import 'package:noteapp/core/services/global_service.dart';
import 'package:noteapp/core/utill/colors.dart';
import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/ui/views/money_collection.dart';
import 'package:flutter/material.dart';

class TransctionItem extends StatelessWidget {
  final laonList.Datum? e;
  final LoanScheduleListModel? allLoanItems = null;
  final DraftCustomerListViewController? draftCustomerListPageController;
  const TransctionItem({
    super.key,
    required this.e,
    allLoanItems,
    this.draftCustomerListPageController,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        GlobalService().pushNavigation(
          MoneyCollection(
            e,
            allLoanItems,
            draftCustomerListPageController: draftCustomerListPageController,
          ),
        );
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(8.0)), // Set rounded corner radius
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Color.fromARGB(255, 225, 225, 225),
                offset: Offset(1, 1),
              )
            ] // Make rounded corner of border
            ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${e?.clientNameLatin} - ${e?.clientNameKh}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Divider(
                color: COLOR_GRAY1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _lableListing("Total"),
                      _lableListing("Principle"),
                      _lableListing("Interest"),
                      _lableListing("Operation Fee"),
                      _lableListing("Village Name"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          "${formatNumberBaseOnCurrency(e?.totalPay, e?.loanCurrency)} ${e?.loanCurrency == "KHR" ? "៛" : "\$"}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      _lableValueListing(
                          "${formatNumberBaseOnCurrency(e?.principleAmt, e?.loanCurrency)} ${e?.loanCurrency == "KHR" ? "៛" : "\$"}"),
                      _lableValueListing(
                          "${formatNumberBaseOnCurrency(e?.interestAmt, e?.loanCurrency)} ${e?.loanCurrency == "KHR" ? "៛" : "\$"}"),
                      _lableValueListing(
                          "${formatNumberBaseOnCurrency(e?.operationFeeAmount, e?.loanCurrency)} ${e?.loanCurrency == "KHR" ? "៛" : "\$"}"),
                      _lableValueListing("${e?.villageName}")
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

_lableListing(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Text(
      "$title :",
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  );
}

_lableValueListing(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Text(title,
        style: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
  );
}
