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

  get tagCapacity => 130;
  int _dataSize = 0;
  get dataSize => _dataSize;

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
    var byteSize = getSize(newTag);

    print("String size in bytes (UTF-8): $byteSize");
    _sizeFlag = byteSize < 130;
    _dataSize = byteSize;
    if (TagValidator.validate(newTag) && sizeFlag)
      observer.getObserver(
        "on_write_activated",
        newTag,
      );

    notifyListeners();
  }

  int getSize(Tag tag) {
    String data = "";
    data += "Owner name: ${tag.name} \r\n";
    data += "Phone number: ${tag.number} \r\n";
    data += "Owner address: ${tag.address} \r\n";
    data += "Pet name: ${tag.petName} \r\n";

    List<int> utf8Bytes = utf8.encode(data);
    int byteSize = utf8Bytes.length;
    return byteSize;
  }
}
