import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/views/dashboard/dashboard_viewmodel.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: Colors.transparent,
        child: Container(
          color: Color.fromARGB(255, 16, 32, 61),
          child: SafeArea(
            child: Column(
              children: [
                if (!viewModel.isNfcEnabled)
                  Expanded(
                    child: RiveAnimation.asset(
                      fit: BoxFit.contain,
                      "packages/domain/assets/animations/attention.riv",
                    ),
                  ),
                if (viewModel.isNfcEnabled)
                  Expanded(child: viewModel.activeScreen),
                if (viewModel.isNfcEnabled)
                  Container(
                    padding: EdgeInsets.all(10),
                    color: ThemeStyles.mainColor,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            callback: viewModel.onAddNewSelected,
                            widget: SvgPicture.asset(
                              "assets/images/add.svg",
                              package: "domain",
                              width: 40,
                              height: 35,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                viewModel.view == ActiveDashboardView.addTag
                                    ? ThemeStyles.secondAccent
                                    : ThemeStyles.secondaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            callback: viewModel.onScanSelected,
                            widget: SvgPicture.asset(
                              "assets/images/scan.svg",
                              package: "domain",
                              width: 40,
                              height: 40,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                viewModel.view == ActiveDashboardView.scanTag
                                    ? ThemeStyles.secondAccent
                                    : ThemeStyles.secondaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            callback: viewModel.onListSelected,
                            widget: SvgPicture.asset(
                              "assets/images/list.svg",
                              package: "domain",
                              width: 40,
                              height: 30,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                viewModel.view == ActiveDashboardView.listTags
                                    ? ThemeStyles.secondAccent
                                    : ThemeStyles.secondaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
