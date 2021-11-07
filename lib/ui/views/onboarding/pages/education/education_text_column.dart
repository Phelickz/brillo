import 'package:brillo/ui/widgets/smart/onboardingWid/col.dart';
import 'package:flutter/material.dart';

class EducationTextColumn extends StatelessWidget {
  const EducationTextColumn();

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Keep learning',
      text: 'Get relevant information about trending topics and guidelines in your preferred interest.',
    );
  }
}