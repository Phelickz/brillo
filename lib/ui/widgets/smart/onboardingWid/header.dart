import 'package:brillo/app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'logo.dart';

class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Logo(
          color: kWhite,
          size: 32.0,
        ),
        TextButton(
          onPressed: onSkip,
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: kWhite,
                ),
          ),
        )
        // GestureDetector(
        //   onTap: onSkip,
        //   child: Text(
        //     'Skip',
        //     style: Theme.of(context).textTheme.subtitle1!.copyWith(
        //           color: kWhite,
        //         ),
        //   ),
        // ),
      ],
    );
  }
}
