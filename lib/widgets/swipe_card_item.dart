// SwipeCardItem Widget

import 'package:flutter/material.dart';
import 'photo_indicators.dart';
import 'photo_navigation.dart';
import 'swipe_action_buttons.dart';

class SwipeCardItem extends StatelessWidget {
  final String imageUrl;
  final int currentPhoto;
  final int numberPhotos;
  final ValueSetter<int> onPhotoChange;
  final VoidCallback onNope;
  final VoidCallback onLike;
  final VoidCallback onSuperlike;

  const SwipeCardItem({
    Key? key,
    required this.imageUrl,
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
                    image: NetworkImage(imageUrl),
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