import 'package:flutter/material.dart';
import 'package:parking_lot_rater/widgets/tabbar_view.dart';
import '../model/card_model.dart';
import '../screens/detail_screen.dart';

class ChoiceReviewerScreen extends StatelessWidget {
	final List<CardModel> favoriteList;
	final List<CardModel> unfavoriteList;

	const ChoiceReviewerScreen({
		Key? key,
		required this.favoriteList,
		required this.unfavoriteList,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
			length: 2, // Number of tabs
			child: Scaffold(
				appBar: AppBar(
					title: Text('Choice Reviewer'),
					bottom: const TabBar(
						tabs: [
							Tab(text: 'Favorite List'),
							Tab(text: 'Unfavorite List'),
						],
					),
				),
				body: TabBarView(
					children: [
						TabbedListView(
							itemList: favoriteList,
							onTap: (index) {
								Navigator.push(
									context,
									MaterialPageRoute(
										builder: (context) => DetailScreen(
											cardModel: favoriteList[index],
											title: 'Favorited Parking Lot',
										),
									),
								);
							},
						),
						TabbedListView(
							itemList: unfavoriteList,
							onTap: (index) {
								Navigator.push(
									context,
									MaterialPageRoute(
										builder: (context) => DetailScreen(
											cardModel: unfavoriteList[index],
											title: 'Unfavorited Parking Lot',
										),
									),
								);
							},
						),
					],
				),
			),
		);
	}
}
