import 'package:noteapp/core/viewmodel/home_view_model.dart';
import 'package:noteapp/ui/views/home/transction_item_collected.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OfflineCollected extends ViewModelWidget<HomeViewModel> {
  const OfflineCollected({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    var loanCollected = viewModel.offLineSubmit?.data ?? [];
    return loanCollected.isNotEmpty == true
        ? Stack(
            children: [
              ListView.builder(
                itemBuilder: (contex, index) {
                  return TransctionItemCollected(
                    e: loanCollected[index],
                    draftCustomerListPageController:
                        viewModel.draftCustomerListPageController,
                  );
                },
                itemCount: loanCollected.length,
              ),
              loanCollected.isNotEmpty && viewModel.isConnected
                  ? Positioned(
                      bottom: 10,
                      right: 24,
                      child: FloatingActionButton(
                        onPressed: viewModel.isConnected
                            ? () async {
                                await viewModel.syncQueuedDataToServerOffline();
                              }
                            : null,
                        backgroundColor:
                            viewModel.isConnected ? Colors.green : Colors.grey,
                        child: const Icon(
                          Icons.sync,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        : const Center(
            child: Text("Opp!, There is no collected loan here."),
          );
  }
}
