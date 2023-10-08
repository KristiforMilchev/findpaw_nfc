import 'package:domain/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_icon_button/custom_icon_button.dart';
import 'package:presentation/components/custom_text_field/custom_text_field.dart';
import 'package:presentation/components/horizontal_divider/horizontal_divider.dart';
import 'package:presentation/views/new_tag/new_tag_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NewTagView extends StatelessWidget {
  const NewTagView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NewTagViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                floatingLabel: "Owner name",
                onChange: viewModel.ownerNameChanged,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                restricted: TextInputType.phone,
                floatingLabel: "Phone number",
                onChange: viewModel.onNumberChanged,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                restricted: TextInputType.streetAddress,
                floatingLabel: "Address",
                onChange: viewModel.onAddressChanged,
              ),
              HorizontalDivider(),
              CustomTextField(
                floatingLabel: "Pet name",
                onChange: viewModel.onPetNameChanged,
              ),
              HorizontalDivider(),
              CustomIconButton(
                label: "Create Tag",
                callback: viewModel.onCreateTagPressed,
              ),
              if (!viewModel.sizeFlag)
                Flexible(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text(
                      "The size of the data exceeds the memory of the nfc tag, writing will likely fail.",
                      style: ThemeStyles.regularParagraphOv(
                        color: ThemeStyles.secondAccent,
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (!viewModel.sizeFlag)
                Flexible(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text(
                      "Tag capacity: ${viewModel.tagCapacity} bytes | Data size: ${viewModel.dataSize} bytes",
                      style: ThemeStyles.regularParagraphOv(
                        color: ThemeStyles.secondAccent,
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
