import 'package:flutter/material.dart';
import '../model/card_model.dart';

class TabbedListView extends StatelessWidget {
  final List<CardModel> itemList;
  final Function(int) onTap;

  const TabbedListView({
    Key? key,
    required this.itemList,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final item = itemList[index];
        return ListTile(
          leading: Image.network(item.imageUrl), // Assuming CardModel has an imageUrl attribute
          title: Text(item.name), // Assuming CardModel has a name attribute
          subtitle: Text(item.liveDate.toString()), // Assuming CardModel has a liveDate attribute
          onTap: () => onTap(index),
        );
      },
    );
  }
}
