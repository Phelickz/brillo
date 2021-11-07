import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:brillo/ui/widgets/smart/onboardingWid/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import './startup_view_model.dart';

class StartupView extends StatefulWidget {
  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (StartupViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        StartupViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // TODO(yazeed): Put Your Logo Here :)
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: kWhite,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: Offset(-1, 1),
                          spreadRadius: 6.0,
                          blurRadius: 2.0)
                    ],
                  ),
                  child: Center(
                    child: Logo(
                      color: kDarkBlue,
                      size: 58,
                    ),
                  ),
                ),
                // const SizedBox(height: 15),
                verticalSpaceMedium(context),
                verticalSpaceMedium(context),
                SpinKitChasingDots(
                  color: kBlue,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
