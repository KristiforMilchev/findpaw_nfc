import 'package:domain/models/tag.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/components/tag_component/tag_component.dart';
import 'package:presentation/views/lock_tag/lock_tag_viewmodel.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class LockTagView extends StatelessWidget {
  final Tag tag;
  const LockTagView({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LockTagViewModel(context, tag),
      builder: (context, viewModel, child) => Container(
        child: Stack(
          children: [
            Column(
              children: [
                TagComponent(tag: tag),
              ],
            ),
            Positioned(
              height: ThemeStyles.height! / 1.03,
              width: ThemeStyles.width,
              child: Container(
                width: 200,
                height: 200,
                child: RiveAnimation.asset(
                  fit: BoxFit.contain,
                  "packages/domain/assets/animations/attention.riv",
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Attention",
                  style: ThemeStyles.regularParagraphOv(
                    color: ThemeStyles.acentColor,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Locking an NFC tag is permanent and irreversible. This ensures that stored data cannot be changed by anyone. Please review data carefully before locking.",
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.secondAccent,
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomIconButton(
                          label: "Cancel",
                          callback: viewModel.onCancelPressed,
                          decorationRadius:
                              BorderRadius.all(Radius.circular(6)),
                          btnRadius: 6,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomIconButton(
                          label: "Confirm",
                          callback: viewModel.onConfirmPressed,
                          solidColor: ThemeStyles.acentColor,
                          decorationRadius:
                              BorderRadius.all(Radius.circular(6)),
                          btnRadius: 6,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
