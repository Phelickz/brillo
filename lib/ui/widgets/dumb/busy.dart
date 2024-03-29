import 'package:brillo/app/utils/constants.dart';
import 'package:brillo/app/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Busy extends StatelessWidget {
  final String? text;

  const Busy({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: text != null ? 180.0 : 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Card(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // SpinKitFadingFour(color: Theme.of(context).primaryColor,),
              SpinKitChasingDots(
                color: kBlue,
              ),
              text != null ? verticalSpaceSmall(context) : SizedBox.shrink(),
              text != null
                  ? Text(
                      text!,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
