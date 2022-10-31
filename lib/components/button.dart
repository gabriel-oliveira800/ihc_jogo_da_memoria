import 'package:flutter/material.dart';

import '../controllers/sounds_controller.dart';
import '../values/app_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback? onPressed;

  const Button({
    Key? key,
    this.style,
    this.onPressed,
    this.text = 'TEXT',
  }) : super(key: key);

  static const TextStyle defaultStyle = TextStyle(
    fontSize: 24,
    color: AppColors.text,
    fontWeight: FontWeight.bold,
  );

  void handleButtonClick() async {
    await SoundsController.instance.playButtonClickSound(onPressed: onPressed);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleButtonClick,
      child: Container(
        width: 234,
        height: 54,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: style ?? defaultStyle,
        ),
      ),
    );
  }
}
