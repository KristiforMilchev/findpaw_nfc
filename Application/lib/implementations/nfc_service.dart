import 'dart:convert';

import 'package:domain/models/tag.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:ndef/ndef.dart' as ndef;

class NfcService implements INfcService {
  @override
  Future<bool> isNfcSuported() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability != NFCAvailability.available) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> readTag() async {
    await FlutterNfcKit.poll();

    for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
      print(record.toString());
      Map<String, dynamic> jsonMap = json.decode(record.toString());
      Tag.fromJson(jsonMap);
    }

    return true;
  }

  @override
  Future<bool> protect() async {
    await FlutterNfcKit.makeNdefReadOnly();
    return true;
  }

  @override
  Future<bool> writeTag(Tag tag) async {
    String jsonString = json.encode(tag.toJson());
    await FlutterNfcKit.poll();
    String data = "";
    data += "${tag.name} \r\n";
    data += "${tag.number} \r\n";
    data += "${tag.address} \r\n";
    data += "${tag.petName} \r\n";
    data += "${tag.note} \r\n";

    await FlutterNfcKit.writeNDEFRecords(
      [
        new ndef.UriRecord.fromString(data),
      ],
    );

    return true;
  }
}
