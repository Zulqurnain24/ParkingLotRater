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
        return ListTile(
          onTap: () => onTap(index),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(itemList[index].imageUrl),
          ),
          title: Text(itemList[index].name),
          subtitle: Text(itemList[index].address),
        );
      },
    );
  }
}
