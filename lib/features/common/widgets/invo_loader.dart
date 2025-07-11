import 'package:flutter/material.dart';
import 'package:invo_app/app/foundations/spacing/spacing.dart';

class InvoLoader extends StatelessWidget {
  const InvoLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsetsGeometry.all(InvoSpaces.space8),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
