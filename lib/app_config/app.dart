import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_lot_rater/app_config/MyAppView.dart';
import 'package:parking_lot_rater/blocs/parking_lots_bloc.dart';
import 'package:parking_lot_rater/repositories/parkinglots_repository.dart';

class MyApp extends StatelessWidget {
  final ParkingLotsRepository parkingLotsRepository;

  const MyApp({super.key, required this.parkingLotsRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ParkingLotsBloc>(
      create: (context) => ParkingLotsBloc(parkingLotsRepository),
      child: const MyAppView(),
    );
  }
}