// SwipeActionButton Widget

import 'package:flutter/material.dart';

class SwipeActionButton extends StatelessWidget {
  final String imagePath;
  final Color borderColor;
  final Color splashColor;
  final Color iconColor;
  final VoidCallback onTap;

  const SwipeActionButton({
    Key? key,
    required this.imagePath,
    required this.borderColor,
    required this.splashColor,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                imagePath,
                color: iconColor,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}