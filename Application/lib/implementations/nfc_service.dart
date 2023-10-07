import 'package:domain/models/tag.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:infrastructure/interfaces/itag_repository.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:domain/models/uri_record_dto.dart';

class NfcService implements INfcService {
  late IObserver _observer;
  late ITagRepository _tagRepository;

  NfcService(IObserver observer, ITagRepository tagRepository) {
    _observer = observer;
    _tagRepository = tagRepository;
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
    try {
      await FlutterNfcKit.poll();
      var tagEmpty = true;
      for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
        tagEmpty = false;
        var tagData = record.toString();
        print(tagData);

        var dto = UriRecordDTO.fromData(tagData);
        var tagInfo = dto.text.split("\r\n");
        if (tagInfo.length < 6) {
          _observer.getObserver(
              "nfc_tag_invalid", "Tag is not in a valid format.");
          return false;
        }

        var tag = Tag(
          name: tagInfo[0],
          number: tagInfo[2],
          address: tagInfo[4],
          petName: tagInfo[6],
          note: tagInfo.length == 9 ? tagInfo[8] : null,
        );
        await _tagRepository.addScan(tag);
        _observer.getObserver("nfc_tag_scanned", tag);
      }
      if (tagEmpty) {
        _observer.getObserver(
          "nfc_tag_invalid",
          "Tag is empty.",
        );
      }
      await FlutterNfcKit.finish();
      return true;
    } catch (exception) {
      var ex = exception as PlatformException;
      if (ex.code == "408") {
      } else {
        _observer.getObserver("nfc_tag_invalid",
            "Error while reading the data, please try again.");
        await FlutterNfcKit.finish();
      }

      return false;
    }
  }

  @override
  Future<bool> protect() async {
    await FlutterNfcKit.poll();

    await FlutterNfcKit.makeNdefReadOnly();
    await FlutterNfcKit.finish();

    return true;
  }

  @override
  Future<bool> writeTag(Tag tag) async {
    await FlutterNfcKit.finish();
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
    await _tagRepository.addTag(tag);
    return true;
  }

  @override
  Future finishSession() async {
    FlutterNfcKit.finish();
  }
}
