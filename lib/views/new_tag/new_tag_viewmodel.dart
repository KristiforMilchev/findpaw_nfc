import 'dart:convert';

import 'package:domain/models/tag.dart';
import 'package:domain/validators/new_tag_validator.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:presentation/page_view_model.dart';

class NewTagViewModel extends PageViewModel {
  late INfcService _nfcService;
  bool _sizeFlag = true;
  bool get sizeFlag => _sizeFlag;

  String _name = "";
  String _phone = "";
  String _address = "";
  String _petName = "";
  String? _note;

  NewTagViewModel(super.context);

  ready() async {
    _nfcService = getIt.get<INfcService>();
    await _nfcService.finishSession();
  }

  ownerNameChanged(String name) {
    _name = name;
  }

  onNumberChanged(String number) {
    _phone = number;
  }

  onAddressChanged(String address) {
    _address = address;
  }

  onPetNameChanged(String petName) {
    _petName = petName;
  }

  onNoteChanged(String note) {
    _note = note;
  }

  onCreateTagPressed() {
    var newTag = Tag(
      name: _name,
      number: _phone,
      address: _address,
      petName: _petName,
      note: _note,
    );

    var map = newTag.toJson();
    var data = json.encode(map);
    List<int> utf8Bytes = utf8.encode(data);
    int byteSize = utf8Bytes.length;

    print("String size in bytes (UTF-8): $byteSize");
    _sizeFlag = byteSize < 137;

    if (TagValidator.validate(newTag) && sizeFlag)
      observer.getObserver(
        "on_write_activated",
        newTag,
      );

    notifyListeners();
  }
}
