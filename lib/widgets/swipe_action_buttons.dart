// SwipeActionButtons Widget

import 'dart:ui';

import 'package:flutter/material.dart';

import 'swipe_action_button.dart';

class SwipeActionButtons extends StatelessWidget {
  final VoidCallback onNope;
  final VoidCallback onLike;
  final VoidCallback onSuperlike;

  const SwipeActionButtons({
    Key? key,
    required this.onNope,
    required this.onLike,
    required this.onSuperlike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SwipeActionButton(
                imagePath: 'assets/icons/clear.png',
                borderColor: Colors.red,
                splashColor: Colors.red,
                iconColor: Theme.of(context).colorScheme.primary,
                onTap: onNope,
              ),
              SwipeActionButton(
                imagePath: 'assets/icons/heart.png',
                borderColor: Colors.greenAccent,
                splashColor: Colors.greenAccent,
                iconColor: Colors.greenAccent,
                onTap: onLike,
              ),
              SwipeActionButton(
                imagePath: 'assets/icons/light.png',
                borderColor: Colors.purple,
                splashColor: Colors.purple,
                iconColor: const Color.fromRGBO(183, 71, 203, 1),
                onTap: onSuperlike,
              ),
            ],
          ),
        ],
      ),
    );
  }
}