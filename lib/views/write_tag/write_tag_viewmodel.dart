import 'package:domain/models/tag.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:presentation/page_view_model.dart';

class WriteTagViewModel extends PageViewModel {
  late INfcService _nfcService;

  final Tag tag;
  WriteTagViewModel(super.context, this.tag);

  bool _writeFinished = false;
  get writeFinished => _writeFinished;

  ready() async {
    try {
      _nfcService = getIt.get<INfcService>();
      await _nfcService.writeTag(tag);
      _writeFinished = true;
      notifyListeners();
      Future.delayed(Duration(seconds: 2), () {
        observer.getObserver('nfc_tag_created', null);
      });
    } catch (ex) {
      ready();
    }
  }
}
