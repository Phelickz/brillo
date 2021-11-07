import 'package:brillo/ui/widgets/smart/onboardingWid/col.dart';
import 'package:flutter/material.dart';

class WorkTextColumn extends StatelessWidget {
  const WorkTextColumn();

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Work together',
      text:
          'Create tranings sessions and work out sessions with people of similar interests.',
    );
  }
}