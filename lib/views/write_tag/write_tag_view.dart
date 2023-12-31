import 'package:domain/models/tag.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/views/write_tag/write_tag_viewmodel.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class WriteTagView extends StatelessWidget {
  final Tag tag;
  const WriteTagView({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => WriteTagViewModel(context, tag),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Container(
        child: Stack(
          children: [
            Visibility(
              visible: viewModel.writeFinished,
              replacement: RiveAnimation.asset(
                fit: BoxFit.contain,
                "packages/domain/assets/animations/write_chip.riv",
              ),
              child: RiveAnimation.asset(
                fit: BoxFit.contain,
                "packages/domain/assets/animations/success_checkmark.riv",
              ),
            ),
            if (viewModel.writeError.isNotEmpty)
              Positioned(
                top: ThemeStyles.height! - 60,
                child: Text(
                  viewModel.writeError,
                  style: ThemeStyles.regularParagraphOv(
                    color: ThemeStyles.acentColor,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
