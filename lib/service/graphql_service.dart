import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class GraphQLService {
  Box? _box;

  Future<ValueNotifier<GraphQLClient>> initializeClient() async {
    // Ensure the Hive box is opened
    _box ??= await Hive.openBox<Map<dynamic, dynamic>>('graphqlCache');
    final HttpLink httpLink = HttpLink('https://interview-apixx07.dev.park-depot.de');

    final Link link = Link.from([httpLink]);

    return ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore(_box as Box<Map?>?)),
        link: link,
      ),
    );
  }

  String getAllParkingLotsQuery = '''
  query {
    getAllParkingLots {
      address
      id
      image
      live_date
      name
      size
      status
      type
    }
  }
  ''';
}
