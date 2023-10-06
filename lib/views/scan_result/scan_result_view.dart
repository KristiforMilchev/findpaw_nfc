import 'package:domain/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/tag_component/tag_component.dart';
import 'package:presentation/views/scan_result/scan_result_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ScanResultView extends StatelessWidget {
  final Tag tag;
  const ScanResultView({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ScanResultViewModel(context, tag),
      builder: (context, viewModel, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TagComponent(
            tag: tag,
            callback: viewModel.onLockPressed,
          )
        ],
      ),
    );
  }
}
