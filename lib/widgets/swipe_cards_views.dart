// SwipeCardsView widget

import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'swipe_card_item.dart';

class SwipeCardsView extends StatelessWidget {
  final MatchEngine matchEngine;
  final List<String> imageUrls;
  final int currentPhoto;
  final int numberPhotos;
  final ValueSetter<int> onPhotoChange;
  final VoidCallback onNope;
  final VoidCallback onLike;
  final VoidCallback onSuperlike;

  const SwipeCardsView({
    Key? key,
    required this.matchEngine,
    required this.imageUrls,
    required this.currentPhoto,
    required this.numberPhotos,
    required this.onPhotoChange,
    required this.onNope,
    required this.onLike,
    required this.onSuperlike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
      matchEngine: matchEngine,
      upSwipeAllowed: true,
      onStackFinished: () {},
      itemBuilder: (context, i) {
        return SwipeCardItem(
          imageUrl: imageUrls.isNotEmpty
              ? imageUrls[i]
              : "https://cdn.dribbble.com/users/55871/screenshots/2158022/media/8f2a4a2c9126a9f265fb9e1023b1698a.jpg?resize=400x0",
          currentPhoto: currentPhoto,
          numberPhotos: numberPhotos,
          onPhotoChange: onPhotoChange,
          onNope: onNope,
          onLike: onLike,
          onSuperlike: onSuperlike,
        );
      },
    );
  }
}
