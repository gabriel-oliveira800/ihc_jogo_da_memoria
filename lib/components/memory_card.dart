import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../models/card_info.dart';
import '../values/app_colors.dart';

class MemoryCard extends StatelessWidget {
  final bool isVisible;
  final CardInfo cardInfo;

  const MemoryCard({
    Key? key,
    required this.cardInfo,
    this.isVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cardInfo is CardInfoAsset && !isVisible) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(child: SvgPicture.asset('assets/images/star.svg')),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(cardInfo.url),
        ),
      ),
    );
  }
}
