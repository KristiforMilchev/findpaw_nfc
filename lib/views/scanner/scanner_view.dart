import 'package:flutter/material.dart';
import 'package:presentation/views/scanner/scanner_viewmodel.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ScannerViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Container(
        child: Stack(
          children: [
            RiveAnimation.asset(
              fit: BoxFit.contain,
              "packages/domain/assets/animations/scanner.riv",
            ),
          ],
        ),
      ),
    );
  }
}
