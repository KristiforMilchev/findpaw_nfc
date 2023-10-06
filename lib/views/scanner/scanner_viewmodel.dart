import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:presentation/page_view_model.dart';

class ScannerViewModel extends PageViewModel {
  late INfcService _nfcService;

  ScannerViewModel(super.context);

  ready() {
    _nfcService = getIt.get<INfcService>();
    startScanner();
  }

  void startScanner() async {
    try {
      await _nfcService.readTag();
    } catch (ex) {
      startScanner();
    }
    startScanner();
  }
}
