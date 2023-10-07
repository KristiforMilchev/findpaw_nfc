import 'package:domain/models/tag.dart';

abstract class ITagRepository {
  Future<bool> addTag(Tag tag);
  Future<bool> addScan(Tag tag);
  Future<List<Tag>> getAddedTags();
  Future<List<Tag>> getScannedTags();
  Future<bool> removeAddedTag(Tag tag);
  Future<bool> removeScannedTag(Tag tag);
}
