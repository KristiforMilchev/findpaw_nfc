import 'package:flutter/foundation.dart';

class Tag {
  String name;
  String number;
  String address;
  String petName;
  String? note;
  bool isLocked;

  Tag({
    required this.name,
    required this.number,
    required this.address,
    required this.petName,
    this.note,
    this.isLocked = false,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      number: json['number'],
      address: json['address'],
      petName: json['petName'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'address': address,
      'petName': petName,
      'note': note,
    };
  }

// Function to serialize a list of tags to JSON
  static List<Map<String, dynamic>> tagsListToJson(List<Tag> tags) {
    return tags.map((tag) => tag.toJson()).toList();
  }

// Function to deserialize a list of tags from JSON
  static List<Tag> tagsListFromJson(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Tag.fromJson(json)).toList();
  }

  static bool isEqual(Tag t1, Tag t2) {
    return t1.name == t2.name &&
        t1.address == t2.address &&
        t1.number == t2.number &&
        t1.petName == t2.petName &&
        t1.note == t2.note;
  }
}
