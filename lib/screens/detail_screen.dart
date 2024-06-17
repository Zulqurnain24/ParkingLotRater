import 'package:flutter/material.dart';
import 'package:parking_lot_rater/model/card_model.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final CardModel cardModel;

  const DetailScreen({super.key, required this.cardModel, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              cardModel.imageUrl,
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text('Name: ${cardModel.content}'),
          ],
        ),
      ),
    );
  }
}
