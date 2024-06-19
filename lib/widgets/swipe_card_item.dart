import 'package:flutter/material.dart';
import 'package:parking_lot_rater/model/card_model.dart';
import 'photo_indicators.dart';
import 'photo_navigation.dart';
import 'swipe_action_buttons.dart';
import 'card_info_text.dart';

class SwipeCardItem extends StatelessWidget {
  final CardModel cardModel;
  final int currentPhoto;
  final int numberPhotos;
  final ValueSetter<int> onPhotoChange;
  final VoidCallback onNope;
  final VoidCallback onLike;
  final VoidCallback onSuperlike;

  const SwipeCardItem({
    Key? key,
    required this.cardModel,
    required this.currentPhoto,
    required this.numberPhotos,
    required this.onPhotoChange,
    required this.onNope,
    required this.onLike,
    required this.onSuperlike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Hero(
          tag: "imageTag${context.hashCode}",
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(cardModel.imageUrl),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // Image Attributes
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardInfoText(label: 'Name', value: cardModel.name),
                    CardInfoText(label: 'Address', value: cardModel.address),
                    CardInfoText(label: 'Size', value: "${cardModel.size}"),
                    CardInfoText(label: 'Live Date', value: cardModel.liveDate),
                    CardInfoText(label: 'Type', value: cardModel.type),
                  ],
                ),
              ),
              PhotoNavigation(
                currentPhoto: currentPhoto,
                numberPhotos: numberPhotos,
                onPhotoChange: onPhotoChange,
              ),
              PhotoIndicators(
                currentPhoto: currentPhoto,
                numberPhotos: numberPhotos,
              ),
              SwipeActionButtons(
                onNope: onNope,
                onLike: onLike,
                onSuperlike: onSuperlike,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
