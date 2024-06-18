import 'package:flutter/material.dart';
import 'package:parking_lot_rater/widgets/tabbed_list_view.dart';
import '../model/card_model.dart';
import '../screens/detail_screen.dart';

class ListTabContent extends StatelessWidget {
  final List<CardModel> itemList;
  final String title;

  const ListTabContent({
    Key? key,
    required this.itemList,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabbedListView(
      itemList: itemList,
      onTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              cardModel: itemList[index],
              title: title,
            ),
          ),
        );
      },
    );
  }
}
