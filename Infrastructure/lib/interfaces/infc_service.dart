import 'package:domain/models/tag.dart';

abstract class INfcService {
  Future<bool> writeTag(Tag tag);
  Future<bool> readTag();
  Future<bool> protect();
  Future<bool> isNfcSuported();
  Future finishSession();
}
