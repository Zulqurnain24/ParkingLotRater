import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_lot_rater/blocs/parking_lots_bloc.dart';
import 'package:parking_lot_rater/blocs/parking_lots_event.dart';
import 'package:parking_lot_rater/blocs/parking_lots_state.dart';
import 'package:parking_lot_rater/screens/choose_reviewer_screen.dart';
import 'package:parking_lot_rater/widgets/app_logo.dart';
import 'package:parking_lot_rater/widgets/error_dialog.dart';
import 'package:parking_lot_rater/widgets/swipe_cards_views.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../model/card_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController(initialPage: 0);
  late MatchEngine _matchEngine;
  int numberPhotos = 1;
  int currentPhoto = 0;

  @override
  void initState() {
    super.initState();
    _matchEngine = MatchEngine(swipeItems: []);
    context.read<ParkingLotsBloc>().add(const FetchParkingLots(5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showConnectivityErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog(
          title: 'Connectivity Issue',
          content: 'Please connect to the internet and try again.',
          onOkPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const AppLogo(),
      ),
      body: BlocBuilder<ParkingLotsBloc, ParkingLotsState>(
        builder: (context, state) {
          if (state is ParkingLotsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ParkingLotsSuccess) {
            List<CardModel> cardModels = [];
            late final List<CardModel> favoriteList = [];
            late final List<CardModel> unfavoriteList = [];
            List<SwipeItem> items = state.parkingLots.item1.map((parkingLot) {
              CardModel? cardModel = CardModel.fromMap(parkingLot);
              if (cardModel != null) {
                cardModels.add(cardModel);
              }
              return SwipeItem(
                content: CardModel.fromMap(parkingLot).content,
                likeAction: () {
                  favoriteList.add(CardModel.fromMap(parkingLot));
                  log("Like");
                },
                nopeAction: () {
                  unfavoriteList.add(CardModel.fromMap(parkingLot));
                  log("Nope");
                },
                superlikeAction: () {
                  favoriteList.add(CardModel.fromMap(parkingLot));
                  log("Superlike");
                },
                onSlideUpdate: (SlideRegion? region) async {
                  log("Region $region");
                },
              );
            }).toList();
            _matchEngine = MatchEngine(swipeItems: items);

            return SwipeCardsView(
              matchEngine: _matchEngine,
              cardModels: cardModels,
              currentPhoto: currentPhoto,
              numberPhotos: numberPhotos,
              onPhotoChange: (newPhoto) {
                setState(() {
                  currentPhoto = newPhoto;
                });
              },
              onNope: () {
                _matchEngine.currentItem!.nope();
              },
              onLike: () {
                _matchEngine.currentItem!.like();
              },
              onSuperlike: () {
                log("List Button Pressed!");
                pushNewScreen(
                  context,
                  withNavBar: true,
                  screen: ChoiceReviewerScreen(
                    favoriteList: favoriteList,
                    unfavoriteList: unfavoriteList,
                  ),
                );
              },
            );
          } else if (state is ParkingLotsFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showConnectivityErrorDialog();
            });
            return const Center(child: Text('Failed to load parking lots'));
          } else {
            return const Center(child: Text('Failed to load parking lots'));
          }
        },
      ),
    );
  }
}




