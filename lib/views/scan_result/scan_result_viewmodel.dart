import 'package:domain/models/tag.dart';
import 'package:presentation/page_view_model.dart';

class ScanResultViewModel extends PageViewModel {
  Tag tag;

  ScanResultViewModel(super.context, this.tag);

  onLockPressed() {
    observer.getObserver('nfc_tag_protect', tag);
  }
}
