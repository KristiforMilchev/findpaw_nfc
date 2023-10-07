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
    List<Tag> tags = [];

    if (scannedTagsData != null) {
      List<dynamic> jsonData = await json.decode(scannedTagsData);
      jsonData.forEach((element) {
        var current = element as Map<String, dynamic>;
        var cTag = Tag.fromJson(current);
        tags.add(cTag);
      });
    }

    if (tags.any((element) => Tag.isEqual(element, tag))) return false;

    tags.add(tag);

    var map = json.encode(tags);
    await _storage.set("findpal_scanned_tags", map);

    return true;
  }

  @override
  Future<bool> addTag(Tag tag) async {
    var createdTagsData = await _storage.get("findpal_created_tags");
    List<Tag> tags = [];
    if (createdTagsData != null) {
      List<dynamic> jsonData = await json.decode(createdTagsData);
      jsonData.forEach((element) {
        var current = element as Map<String, dynamic>;
        var cTag = Tag.fromJson(current);
        tags.add(cTag);
      });
    }

    if (tags.any((element) => Tag.isEqual(element, tag))) return false;

    tags.add(tag);

    var map = json.encode(tags);
    await _storage.set("findpal_created_tags", map);

    return true;
  }

  @override
  Future<List<Tag>> getAddedTags() async {
    var createdTagsData = await _storage.get("findpal_created_tags");
    if (createdTagsData == null) {
      return [];
    }
    List<Tag> tags = [];
    List<dynamic> jsonData = await json.decode(createdTagsData);
    jsonData.forEach((element) {
      var current = element as Map<String, dynamic>;
      var cTag = Tag.fromJson(current);
      tags.add(cTag);
    });
    return tags;
  }

  @override
  Future<List<Tag>> getScannedTags() async {
    var scannedTagsData = await _storage.get("findpal_scanned_tags");

    if (scannedTagsData == null) {
      return [];
    }

    List<Tag> tags = [];
    List<dynamic> jsonData = await json.decode(scannedTagsData);
    jsonData.forEach((element) {
      var current = element as Map<String, dynamic>;
      var cTag = Tag.fromJson(current);
      tags.add(cTag);
    });
    return tags;
  }

  @override
  Future<bool> removeAddedTag(Tag tag) async {
    var createdTagsData = await _storage.get("findpal_created_tags");
    List<Tag> tags = [];
    if (createdTagsData != null) {
      List<Tag> tags = [];
      List<dynamic> jsonData = await json.decode(createdTagsData);
      jsonData.forEach((element) {
        var current = element as Map<String, dynamic>;
        var cTag = Tag.fromJson(current);
        tags.add(cTag);
      });
    }

    if (!tags.any((element) => Tag.isEqual(element, tag))) return false;

    tags.remove(tag);

    var map = json.encode(tags);
    await _storage.set("findpal_created_tags", map);

    return true;
  }

  @override
  Future<bool> removeScannedTag(Tag tag) async {
    var scannedTagsData = await _storage.get("findpal_scanned_tags");
    List<Tag> tags = [];

    if (scannedTagsData != null) {
      List<Tag> tags = [];
      List<dynamic> jsonData = await json.decode(scannedTagsData);
      jsonData.forEach((element) {
        var current = element as Map<String, dynamic>;
        var cTag = Tag.fromJson(current);
        tags.add(cTag);
      });
    }

    if (!tags.any((element) => Tag.isEqual(element, tag))) return false;

    tags.remove(tag);

    var map = json.encode(tags);
    await _storage.set("findpal_scanned_tags", map);

    return true;
  }
}
