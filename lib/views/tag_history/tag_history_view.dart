import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/tag_component/tag_component.dart';
import 'package:presentation/views/tag_history/tag_history_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TagHistoryView extends StatelessWidget {
  const TagHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TagHistoryViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: Column(
          children: [
            if (viewModel.createdTags.isNotEmpty)
              Text(
                "Created Tags",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.acentColor,
                  size: 20,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ...viewModel.createdTags.map((e) => TagComponent(tag: e)).toList(),
            if (viewModel.scannedTags.isNotEmpty)
              Text(
                "Scanned Tags",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.acentColor,
                  size: 20,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ...viewModel.scannedTags.map((e) => TagComponent(tag: e)).toList()
          ],
        ),
      ),
    );
  }
}
