// SwipeCardsView widget

import 'package:flutter/material.dart';
import 'package:parking_lot_rater/model/card_model.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'swipe_card_item.dart';

class SwipeCardsView extends StatelessWidget {
  final MatchEngine matchEngine;
  final List<CardModel> cardModels;
  final int currentPhoto;
  final int numberPhotos;
  final ValueSetter<int> onPhotoChange;
  final VoidCallback onNope;
  final VoidCallback onLike;
  final VoidCallback onSuperlike;

  const SwipeCardsView({
    Key? key,
    required this.matchEngine,
    required this.cardModels,
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
          cardModel: cardModels[i],
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
