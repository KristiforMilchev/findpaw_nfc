import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

import 'splash_viewmodel.dart';

class Splashs extends StatelessWidget {
  const Splashs({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(context),
      builder: (context, viewModel, child) => Container(
          child: Stack(
        children: [
          RiveAnimation.asset(
            fit: BoxFit.cover,
            "packages/domain/assets/animations/splash.riv",
          ),
        ],
      )),
    );
  }
}
