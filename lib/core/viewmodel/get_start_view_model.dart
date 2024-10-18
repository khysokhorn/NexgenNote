import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/viewmodel/app_base_view_model.dart';

class GetStartViewModel extends AppBaseViewModel {
  @override
  Future<void> getInstance() async {
    try {
      setInitialised(true);
      notifyListeners();
    } catch (e) {
      GlobalFunction.printDebugMessage(e);
      GlobalFunction.onHttpRequestFail(e, this);
      setBusy(false);
      notifyListeners();
    }
  }
}
