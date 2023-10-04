import 'package:domain/models/tag.dart';

class TagValidator {
  static bool validate(Tag tag) {
    if (tag.address.isEmpty) return false;
    if (tag.name.isEmpty) return false;
    if (tag.number.isEmpty) return false;
    if (tag.petName.isEmpty) return false;

    return true;
  }
}
