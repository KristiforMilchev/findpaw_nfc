import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/views/scan_failed/scan_failed_viewmodel.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class ScanFailedView extends StatelessWidget {
  final String scanResult;

  const ScanFailedView({super.key, required this.scanResult});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ScanFailedViewModel(context),
      builder: (context, viewModel, child) => Container(
        child: Stack(
          children: [
            RiveAnimation.asset(
              fit: BoxFit.contain,
              "packages/domain/assets/animations/scan_failed.riv",
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "It appears there is a problem",
                        style: ThemeStyles.regularParagraphOv(
                          color: ThemeStyles.acentColor,
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          scanResult,
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.secondAccent,
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            CustomIconButton(
              label: "Try again.",
              callback: viewModel.onScanAgainPressed,
              solidColor: ThemeStyles.secondAccent,
              decorationRadius: BorderRadius.all(Radius.circular(6)),
              btnRadius: 6,
            )
          ],
        ),
      ),
    );
  }
}
