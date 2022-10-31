import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:ihc_jogo_da_memoria/controllers/sounds_controller.dart';

import '../values/app_colors.dart';

class ActionIcon extends StatelessWidget {
  final bool isActive;
  final bool isSoundOn;
  final String? svgSource;
  final IconData? activeIcon;
  final IconData? desableIcon;
  final VoidCallback? onPressed;

  const ActionIcon({
    Key? key,
    this.desableIcon,
    this.onPressed,
    this.svgSource,
    this.activeIcon,
    this.isActive = true,
    this.isSoundOn = true,
  }) : super(key: key);

  void handleButtonClick() async {
    await SoundsController.instance.playButtonClickSound(onPressed: onPressed);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: SoundsController.instance,
      builder: (context, child) => InkWell(
        onTap: handleButtonClick,
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: svgSource != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(svgSource!),
                )
              : Icon(color: AppColors.text, isActive ? activeIcon : desableIcon),
        ),
      ),
    );
  }
}
