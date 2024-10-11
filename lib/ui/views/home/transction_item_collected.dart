import 'package:noteapp/core/model/request/post_loan_collection.dart';
import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart'
    as laonList;
import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart';
import 'package:noteapp/core/services/global_service.dart';
import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/ui/views/money_collection.dart';
import 'package:flutter/material.dart';

class TransctionItemCollected extends StatelessWidget {
  final PostLoanCollection? e;
  final LoanScheduleListModel? allLoanItems = null;
  final DraftCustomerListViewController? draftCustomerListPageController;
  const TransctionItemCollected({
    super.key,
    required this.e,
    allLoanItems,
    this.draftCustomerListPageController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${e?.clientNameLatin} - ${e?.clientNameKh}",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${e?.totalPay}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Principle : ${e?.principleAmt}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text("Interest : ${e?.interestAmt}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Operation Fee : ${e?.operationFeeAmount}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text("${e?.loanCurrency}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
