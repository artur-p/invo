import 'package:flutter/cupertino.dart';
import 'package:invo_app/app/foundations/styles/app_text_style.dart';

class BigHeader extends StatelessWidget {
  const BigHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.textStyles.textTheme.headlineSmall);
  }
}
