import 'package:domain/models/tag.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:presentation/page_view_model.dart';

class WriteTagViewModel extends PageViewModel {
  late INfcService _nfcService;

  final Tag tag;
  WriteTagViewModel(super.context, this.tag);

  ready() async {
    _nfcService = getIt.get<INfcService>();
    await _nfcService.writeTag(tag);
    observer.getObserver('nfc_tag_created', null);
  }
}
