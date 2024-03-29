import 'package:brillo/app/utils/res.dart';
import 'package:brillo/ui/views/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Onboarding(screenHeight: McGyver.rsDoubleH(context, 100),);
      },
    );
  }
}
