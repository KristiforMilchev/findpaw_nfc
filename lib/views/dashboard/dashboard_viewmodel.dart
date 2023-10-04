import 'package:domain/models/enums.dart';
import 'package:domain/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:presentation/page_view_model.dart';
import 'package:presentation/views/new_tag/new_tag_view.dart';
import 'package:presentation/views/scanner/scanner_view.dart';
import 'package:presentation/views/write_tag/write_tag_view.dart';

class DashboardViewModel extends PageViewModel {
  late INfcService _nfcService;
  Widget _activeScreen = ScannerView();
  Widget get activeScreen => _activeScreen;

  ActiveDashboardView _activeView = ActiveDashboardView.scanTag;
  ActiveDashboardView get view => _activeView;

  DashboardViewModel(super.context);

  ready() {
    _nfcService = getIt.get<INfcService>();
    startScanner();
    observer.subscribe("on_write_activated", onWriteActivated);
    observer.subscribe("nfc_tag_created", onTagWritten);
  }

  onAddNewSelected() {
    _activeView = ActiveDashboardView.addTag;
    _activeScreen = NewTagView();
    notifyListeners();
  }

  onScanSelected() {
    _activeView = ActiveDashboardView.scanTag;
    _activeScreen = ScannerView();
    notifyListeners();
  }

  onListSelected() {
    _activeView = ActiveDashboardView.listTags;
    notifyListeners();
  }

  onWriteActivated(Tag current) {
    _activeScreen = WriteTagView(
      tag: current,
    );
    notifyListeners();
  }

  onTagWritten() {
    _activeScreen = ScannerView();
    _activeView = ActiveDashboardView.scanTag;
  }

  void startScanner() {
    _nfcService.readTag();
  }
}
