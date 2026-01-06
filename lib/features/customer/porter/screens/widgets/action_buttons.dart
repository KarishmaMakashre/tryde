import 'package:flutter/material.dart';
import 'package:tryde/core/constants/color_constants.dart';


class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _iconButton(Icons.call, () {}),
        _iconButton(Icons.chat, () {}),
        _iconButton(Icons.notifications, () {}),
      ],
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: AppColors.porterPrimary.withOpacity(0.1),
        child: Icon(
          icon,
          color:AppColors.porterPrimary,
          size: 26,
        ),
      ),
    );
  }
}
