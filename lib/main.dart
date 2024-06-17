import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parking_lot_rater/app_config/app.dart';
import 'repositories/parkinglots_repository.dart';
import 'service/graphql_service.dart';
import 'observer/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GraphQL client
  final HttpLink httpLink = HttpLink('https://interview-apixx07.dev.park-depot.de');
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: httpLink,
  );

  // Initialize the repository
  final parkingLotsRepository = ParkingLotsRepository(client, GraphQLService());

  // Set up the BLoC observer for debugging
  Bloc.observer = SimpleBlocObserver();

  // Run the app
  runApp(MyApp(parkingLotsRepository: parkingLotsRepository));
}