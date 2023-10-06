import 'package:presentation/page_view_model.dart';

class ScanFailedViewModel extends PageViewModel {
  ScanFailedViewModel(super.context);

  onScanAgainPressed() {
    observer.getObserver("nfc_scan_again", null);
  }
}
