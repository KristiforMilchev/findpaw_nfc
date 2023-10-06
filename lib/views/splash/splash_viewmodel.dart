import 'package:presentation/page_view_model.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends PageViewModel {
  SplashViewModel(super.context);

  ready(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1600), () {
      router.changePage(
        "/dashboard-view",
        pageContext,
        TransitionData(next: PageTransition.easeInAndOut),
      );
    });
  }
}
