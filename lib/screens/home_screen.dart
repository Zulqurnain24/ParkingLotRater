import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_lot_rater/blocs/parking_lots_bloc.dart';
import 'package:parking_lot_rater/blocs/parking_lots_event.dart';
import 'package:parking_lot_rater/blocs/parking_lots_state.dart';
import 'package:parking_lot_rater/screens/choose_reviewer_screen.dart';
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
        return AlertDialog(
          title: Text('Connectivity Issue'),
          content: Text('Please connect to the internet and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/wemolo_logo.png",
              scale: 18,
            ),
            Text(
              'emolo',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ParkingLotsBloc, ParkingLotsState>(
        builder: (context, state) {
          if (state is ParkingLotsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ParkingLotsSuccess) {
            List<String> imageUrls = [];
            late final List<CardModel> favoriteList = [];
            late final List<CardModel> unfavoriteList = [];
            List<SwipeItem> items = state.parkingLots.item1.map((parkingLot) {
              String? imageUrl = parkingLot["image"]?.toString();
              if (imageUrl != null) {
                imageUrls.add(imageUrl);
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
            return SwipeCards(
              matchEngine: _matchEngine,
              upSwipeAllowed: true,
              onStackFinished: () {},
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Hero(
                      tag: "imageTag$i",
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  imageUrls.isNotEmpty
                                      ? imageUrls[i]
                                      : "https://cdn.dribbble.com/users/55871/screenshots/2158022/media/8f2a4a2c9126a9f265fb9e1023b1698a.jpg?resize=400x0",
                                ),
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
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (currentPhoto != 0) {
                                      setState(() {
                                        currentPhoto = currentPhoto - 1;
                                      });
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
                                      setState(() {
                                        currentPhoto = currentPhoto + 1;
                                      });
                                    }
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
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
                                        width: ((MediaQuery.of(context)
                                            .size
                                            .width -
                                            (20 +
                                                ((numberPhotos + 1) * 8))) /
                                            numberPhotos),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 0.5,
                                          ),
                                          color: currentPhoto == i
                                              ? Colors.white
                                              : Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: Colors.red,
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        onTap: () {
                                          _matchEngine.currentItem!.nope();
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.red,
                                            ),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(12.0),
                                              child: Image.asset(
                                                'assets/icons/clear.png',
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          _matchEngine.currentItem!.like();
                                        },
                                        splashColor: Colors.greenAccent,
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.greenAccent,
                                            ),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              child: Image.asset(
                                                'assets/icons/heart.png',
                                                color: Colors.greenAccent,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
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
                                        splashColor: Colors.purple,
                                        borderRadius: BorderRadius.circular(100),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.purple,
                                            ),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'assets/icons/light.png',
                                                color: const Color.fromRGBO(183, 71, 203, 1),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ParkingLotsFailure) {
            // Show alert dialog when there is a failure state
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showConnectivityErrorDialog();
            });
            return Center(child: Text('Failed to load parking lots'));
          } else {
            return Center(child: Text('Failed to load parking lots'));
          }
        },
      ),
    );
  }
}
