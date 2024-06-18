import 'package:flutter/material.dart';
import 'package:parking_lot_rater/widgets/list_tab_content.dart';
import '../model/card_model.dart';
import '../widgets/tabbed_list_view.dart';
import '../widgets/app_bar_widget.dart';

class ChoiceReviewerScreen extends StatelessWidget {
	final List<CardModel> favoriteList;
	final List<CardModel> unfavoriteList;

	ChoiceReviewerScreen({
		Key? key,
		required List<CardModel> favoriteList,
		required List<CardModel> unfavoriteList,
	})  : favoriteList = List.of(favoriteList),
				unfavoriteList = List.of(unfavoriteList),
				super(key: key) {
		favoriteList.sort((a, b) => a.liveDate.compareTo(b.liveDate));
		unfavoriteList.sort((a, b) => a.liveDate.compareTo(b.liveDate));
	}

	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
			length: 2, // Number of tabs
			child: Scaffold(
				appBar: AppBarWidget(),
				body: TabBarView(
					children: [
						ListTabContent(
							itemList: favoriteList,
							title: 'Favorited Parking Lot',
						),
						ListTabContent(
							itemList: unfavoriteList,
							title: 'Unfavorited Parking Lot',
						),
					],
				),
			),
		);
	}
}
