import 'dart:convert';

import 'package:domain/models/tag.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/itag_repository.dart';

class TagRepository implements ITagRepository {
  late IlocalStorage _storage;

  TagRepository(IlocalStorage localStorage) {
    _storage = localStorage;
  }

  @override
  Future<bool> addScan(Tag tag) async {
    var scannedTagsData = await _storage.get("findpal_scanned_tags");
    List<Map<String, dynamic>> jsonData = json.decode(scannedTagsData);
    var tags = Tag.tagsListFromJson(jsonData);
    if (tags.any((element) => Tag.isEqual(element, tag))) return false;

    tags.add(tag);

    var map = json.encode(tags);
    _storage.set("findpal_scanned_tags", map);

    return true;
  }

  @override
  Future<bool> addTag(Tag tag) async {
    var createdTagsData = await _storage.get("findpal_created_tags");
    List<Map<String, dynamic>> jsonData = json.decode(createdTagsData);
    var tags = Tag.tagsListFromJson(jsonData);
    if (tags.any((element) => Tag.isEqual(element, tag))) return false;

    tags.add(tag);

    var map = json.encode(tags);
    _storage.set("findpal_created_tags", map);

    return true;
  }

  @override
  Future<List<Tag>> getAddedTags() async {
    var createdTagsData = await _storage.get("findpal_created_tags");
    List<Map<String, dynamic>> jsonData = json.decode(createdTagsData);
    return Tag.tagsListFromJson(jsonData);
  }

  @override
  Future<List<Tag>> getScannedTags() async {
    var scannedTagsData = await _storage.get("findpal_scanned_tags");
    List<Map<String, dynamic>> jsonData = json.decode(scannedTagsData);
    return Tag.tagsListFromJson(jsonData);
  }

  @override
  Future<bool> removeAddedTag(Tag tag) async {
    var createdTagsData = await _storage.get("findpal_created_tags");
    List<Map<String, dynamic>> jsonData = json.decode(createdTagsData);
    var tags = Tag.tagsListFromJson(jsonData);
    if (!tags.any((element) => Tag.isEqual(element, tag))) return false;

    tags.remove(tag);

    var map = json.encode(tags);
    _storage.set("findpal_created_tags", map);

    return true;
  }

  @override
  Future<bool> removeScannedTag(Tag tag) async {
    var scannedTagsData = await _storage.get("findpal_scanned_tags");
    List<Map<String, dynamic>> jsonData = json.decode(scannedTagsData);
    var tags = Tag.tagsListFromJson(jsonData);
    if (!tags.any((element) => Tag.isEqual(element, tag))) return false;

    tags.remove(tag);

    var map = json.encode(tags);
    _storage.set("findpal_scanned_tags", map);

    return true;
  }
}
