// IconIndicatorWidget

import 'package:flutter/material.dart';

class PhotoIndicators extends StatelessWidget {
  final int currentPhoto;
  final int numberPhotos;

  const PhotoIndicators({
    Key? key,
    required this.currentPhoto,
    required this.numberPhotos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: 6,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: numberPhotos,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int i) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: ((MediaQuery.of(context).size.width - (20 + ((numberPhotos + 1) * 8))) / numberPhotos),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 0.5,
                    ),
                    color: currentPhoto == i
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}