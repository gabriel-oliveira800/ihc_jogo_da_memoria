import 'package:flutter/material.dart';

import 'package:ihc_jogo_da_memoria/controllers/game_controller.dart';
import 'package:ihc_jogo_da_memoria/values/app_colors.dart';

import 'button.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GameController.instance,
      builder: (_, __) => Dialog(
        elevation: 0,
        alignment: Alignment.center,
        backgroundColor: AppColors.tertiary,
        child: Container(
          width: 300,
          height: 200,
          color: AppColors.text,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: GameDifficulty.values.map((it) {
              final isActive = GameController().difficulty == it;

              return InkWell(
                onTap: () {
                  GameController().chooseDifficulty(it);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    it.name,
                    style: Button.defaultStyle.copyWith(
                      color: isActive ? AppColors.primary : Colors.grey,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
