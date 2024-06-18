// PhotoNavigation Widget

import 'package:flutter/material.dart';

class PhotoNavigation extends StatelessWidget {
  final int currentPhoto;
  final int numberPhotos;
  final ValueSetter<int> onPhotoChange;

  const PhotoNavigation({
    Key? key,
    required this.currentPhoto,
    required this.numberPhotos,
    required this.onPhotoChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (currentPhoto != 0) {
                onPhotoChange(currentPhoto - 1);
              }
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (currentPhoto < (numberPhotos - 1)) {
                onPhotoChange(currentPhoto + 1);
              }
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}