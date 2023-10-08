import 'package:domain/models/tag.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:presentation/page_view_model.dart';

class LockTagViewModel extends PageViewModel {
  late INfcService _nfcService;
  Tag tag;
  LockTagViewModel(super.context, this.tag);

  bool _writeFinished = false;
  bool get writeFinished => _writeFinished;

  ready() {
    _nfcService = getIt.get<INfcService>();
    _nfcService.finishSession();
  }

  onCancelPressed() {
    observer.getObserver("nfc_scan_again", null);
  }

  onConfirmPressed() async {
    await _nfcService.protect();
    _writeFinished = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 2), () {
      observer.getObserver("nfc_scan_again", null);
    });
  }
}
