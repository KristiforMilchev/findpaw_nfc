import 'package:domain/models/tag.dart';
import 'package:infrastructure/interfaces/itag_repository.dart';
import 'package:presentation/page_view_model.dart';

class TagHistoryViewModel extends PageViewModel {
  late ITagRepository _tagRepository;
  List<Tag> _createdTags = [];
  List<Tag> get createdTags => _createdTags;

  List<Tag> _scannedTags = [];
  List<Tag> get scannedTags => _scannedTags;

  TagHistoryViewModel(super.context);

  ready() async {
    _tagRepository = getIt.get<ITagRepository>();

    _createdTags = await _tagRepository.getAddedTags();
    var scannedData = await _tagRepository.getScannedTags();
    _scannedTags = scannedData
        .where(
          (element) => !_createdTags.any(
            (created) => Tag.isEqual(
              element,
              created,
            ),
          ),
        )
        .toList();

    notifyListeners();
  }
}
