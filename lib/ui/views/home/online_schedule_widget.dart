import 'package:noteapp/core/utill/colors.dart';
import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/ui/views/home/transction_item.dart';
import 'package:noteapp/ui/widgets/radius_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OnlineScheduleWidget extends ViewModelWidget<HomeViewModel> {
  const OnlineScheduleWidget({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    var data = viewModel.refreshdDataSource?.data ?? [];
    return Column(children: [
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.93,
        child: TextFormField(
          keyboardType: TextInputType.name,
          controller: viewModel.searchValue,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.0),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Search customer name',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          onChanged: viewModel.searchCustomerInListview,
        ),
      ),
      data.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                itemBuilder: (contex, index) {
                  var e = data[index];
                  return TransctionItem(
                    e: e,
                    draftCustomerListPageController:
                        viewModel.draftCustomerListPageController,
                  );
                },
                itemCount: data.length,
              ),
            )
          : const Expanded(
              child: Center(
              child: Text("Opp!, There is no loan here."),
            ))
    ]);
  }
}
