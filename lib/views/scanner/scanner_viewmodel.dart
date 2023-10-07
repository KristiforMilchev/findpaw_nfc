import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:presentation/page_view_model.dart';

class ScannerViewModel extends PageViewModel {
  late INfcService _nfcService;

  ScannerViewModel(super.context);

  ready() {
    _nfcService = getIt.get<INfcService>();
    observer.subscribe("nfc_scan_again", onScanRequest);
    startScanner();
  }

  void startScanner() async {
    await _nfcService.readTag();

    startScanner();
  }

  onScanRequest() {
    startScanner();
  }
}
