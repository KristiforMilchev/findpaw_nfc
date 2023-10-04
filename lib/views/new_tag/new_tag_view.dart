import 'package:domain/styles.dart';
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
                floatingLabel: "Phone number",
                onChange: viewModel.onNumberChanged,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                floatingLabel: "Address",
                onChange: viewModel.onAddressChanged,
              ),
              HorizontalDivider(),
              CustomTextField(
                floatingLabel: "Pet name",
                onChange: viewModel.onPetNameChanged,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                floatingLabel: "Note",
                onChange: viewModel.onNoteChanged,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: !viewModel.autoGeneratePassword,
                    child: Expanded(
                      child: CustomTextField(
                        floatingLabel: "Manual tag password",
                        onChange: viewModel.onManualPasswordChanged,
                      ),
                    ),
                    replacement: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Text(
                                    "Generated tag password",
                                    style: ThemeStyles.regularParagraphOv(
                                      size: 12,
                                      color: ThemeStyles.secondAccent,
                                      weight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    viewModel.randomPasswrd,
                                    style: ThemeStyles.regularParagraphOv(
                                      size: 15,
                                      color: ThemeStyles.secondAccent,
                                      weight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Switch(
                    value: viewModel.autoGeneratePassword,
                    inactiveTrackColor: ThemeStyles.darkBtnSolid,
                    activeTrackColor: ThemeStyles.secondaryColor,
                    thumbColor:
                        MaterialStatePropertyAll(ThemeStyles.secondAccent),
                    onChanged: viewModel.onPasswordToggleChanged,
                  )
                ],
              ),
              const SizedBox(height: 10),
              CustomIconButton(
                label: "Create Tag",
                callback: viewModel.onCreateTagPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
