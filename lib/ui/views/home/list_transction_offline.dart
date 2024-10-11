import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/ui/views/home/transction_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OfflineSchedule extends ViewModelWidget<HomeViewModel> {
  const OfflineSchedule({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    var data1 = viewModel.refreshDataSourceOffline?.data ?? [];
    // print("data $data1");
    return Column(children: [
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.93,
        child: TextFormField(
          keyboardType: TextInputType.name,
          controller: viewModel.searchValueOffline,
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
          onChanged: viewModel.searchCustomerInListviewOffline,
        ),
      ),
      data1.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                itemBuilder: (contex, index) {
                  var e = data1[index];
                  return TransctionItem(
                    e: e,
                    allLoanItems: viewModel.refreshDataSourceOffline,
                    draftCustomerListPageController:
                        viewModel.draftCustomerListPageController,
                  );
                },
                itemCount: data1.length,
              ),
            )
          : const Expanded(
              child: Center(
              child: Text("Opp!, There is no data offline here."),
            ))
    ]);
    /*return Column(children: [
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.93,
        child: TextFormField(
          keyboardType: TextInputType.name,
          controller: viewModel.searchValueOffline,
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
          onChanged: viewModel.searchCustomerInListviewOffline,
        ),
      ),
      return data1.isNotEmpty
        ? ListView.builder(
            itemBuilder: (contex, index) {
              var e = data1[index];
              return TransctionItem(
                e: e, allLoanItems: viewModel.refreshDataSourceOffline,
              );
            },
            itemCount: data1.length ?? 0,
          )
        :  const Expanded(
              child: Center(
              child: Text("Opp!, There is no data offline here."),
            )
    );*/
  }
}
