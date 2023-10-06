import 'package:domain/models/tag.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:domain/models/uri_record_dto.dart';

class NfcService implements INfcService {
  late IObserver _observer;

  NfcService(IObserver observer) {
    _observer = observer;
  }

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
      var tagData = record.toString();
      print(tagData);

      var dto = UriRecordDTO.fromData(tagData);
      var tagInfo = dto.text.split("\r\n");

      var tag = Tag(
        name: tagInfo[0],
        number: tagInfo[2],
        address: tagInfo[4],
        petName: tagInfo[6],
        note: tagInfo.length == 7 ? tagInfo[6] : null,
      );

      _observer.getObserver("nfc_tag_scanned", tag);
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
    var poll = await FlutterNfcKit.poll();
    if (poll.ndefAvailable == null) {}
    String data = "";
    data += "Owner name: ${tag.name} \r\n";
    data += "\r\n";
    data += "Phone number: ${tag.number} \r\n";
    data += "\r\n";
    data += "Owner address: ${tag.address} \r\n";
    data += "\r\n";
    data += "Pet name: ${tag.petName} \r\n";

    if (tag.note != null) {
      data += "Note: \r\n";
      data += tag.note!;
    }

    await FlutterNfcKit.writeNDEFRecords(
      [
        new ndef.TextRecord(
          text: data,
          encoding: ndef.TextEncoding.UTF8,
          language: "English",
        ),
      ],
    );

    return true;
  }
}
