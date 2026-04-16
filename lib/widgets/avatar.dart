import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';

class Avatar extends StatelessWidget {
  final String avatarSeed;

  const Avatar({super.key, required this.avatarSeed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: DiceBearRequest(
        style: DiceBearStyle.notionistsNeutral,
        coreOptions: DiceBearCoreOptions(seed: avatarSeed),
      ).toImage(width: 38, height: 38),
    );
  }
}
