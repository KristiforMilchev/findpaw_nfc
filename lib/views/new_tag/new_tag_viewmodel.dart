import 'package:domain/models/tag.dart';
import 'package:domain/validators/new_tag_validator.dart';
import 'package:presentation/page_view_model.dart';

class NewTagViewModel extends PageViewModel {
  bool _autoGeneratePassword = true;
  bool get autoGeneratePassword => _autoGeneratePassword;

  String _name = "";
  String _phone = "";
  String _address = "";
  String _petName = "";
  String? _note;

  NewTagViewModel(super.context);

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

  void onPasswordToggleChanged(bool value) {
    _autoGeneratePassword = value;
    notifyListeners();
  }

  onCreateTagPressed() {
    var newTag = Tag(
      name: _name,
      number: _phone,
      address: _address,
      petName: _petName,
      note: _note,
    );

    //if (TagValidator.validate(newTag))

    observer.getObserver(
      "on_write_activated",
      newTag,
    );
  }
}
