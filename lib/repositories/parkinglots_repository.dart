import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parking_lot_rater/service/graphql_service.dart';
import 'package:tuple/tuple.dart';

class ParkingLotsRepository {
  final GraphQLClient client;
  final GraphQLService graphQLService;

  ParkingLotsRepository(this.client, this.graphQLService);

  Future<Tuple2<List<Map<String, dynamic>>, int>> fetchInitialParkingLots(int pageSize) async {
    final QueryOptions options = QueryOptions(
      document: gql(graphQLService.getAllParkingLotsQuery),
      variables: {'first': pageSize}, // Assuming the query uses a 'first' parameter for pagination
    );
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final List parkingLots = result.data?['getAllParkingLots'] ?? [];
    return Tuple2(parkingLots.cast<Map<String, dynamic>>(), 1);
  }

  Future<Tuple2<List<Map<String, dynamic>>, int>> fetchMoreParkingLots(int page, int pageSize) async {
    final QueryOptions options = QueryOptions(
      document: gql(graphQLService.getAllParkingLotsQuery),
      variables: {'first': pageSize, 'page': page}, // Assuming the query uses 'first' and 'page' parameters for pagination
    );
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final List parkingLots = result.data?['getAllParkingLots'] ?? [];
    return Tuple2(parkingLots.cast<Map<String, dynamic>>(), page + 1);
  }
}
