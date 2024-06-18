import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:parking_lot_rater/blocs/parking_lots_bloc.dart';
import 'package:parking_lot_rater/blocs/parking_lots_event.dart';
import 'package:parking_lot_rater/blocs/parking_lots_state.dart';
import 'package:parking_lot_rater/repositories/parkinglots_repository.dart';
import 'package:parking_lot_rater/screens/home_screen.dart';
import 'package:parking_lot_rater/service/graphql_service.dart';
import 'package:tuple/tuple.dart';
import 'package:mocktail/mocktail.dart';

// Generate mocks for the listed classes
@GenerateMocks([
  ParkingLotsBloc,
  ParkingLotsRepository,
  GraphQLClient,
  GraphQLService,
])
void main() {
  late ParkingLotsBloc parkingLotsBloc;

  setUp(() {
    parkingLotsBloc = MockParkingLotsBloc();
  });

  group('HomeScreen', () {
    testWidgets('displays loading indicator when state is ParkingLotsLoading',
            (WidgetTester tester) async {
          when(() => parkingLotsBloc.state).thenReturn(ParkingLotsLoading());

          await tester.pumpWidget(
            BlocProvider<ParkingLotsBloc>(
              create: (_) => parkingLotsBloc,
              child: MaterialApp(
                home: HomeScreen(),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        });

    testWidgets('displays error message when state is ParkingLotsFailure',
            (WidgetTester tester) async {
          when(() => parkingLotsBloc.state).thenReturn(ParkingLotsFailure());

          await tester.pumpWidget(
            BlocProvider<ParkingLotsBloc>(
              create: (_) => parkingLotsBloc,
              child: MaterialApp(
                home: HomeScreen(),
              ),
            ),
          );

          expect(find.text('Failed to load parking lots'), findsOneWidget);
        });
  });
}

class MockParkingLotsBloc extends MockBloc<ParkingLotsEvent, ParkingLotsState> implements ParkingLotsBloc {
  MockParkingLotsBloc() : super();

  @override
  Stream<ParkingLotsState> mapEventToState(ParkingLotsEvent event) async* {
    if (event is FetchParkingLots) {
      yield* _mapFetchParkingLotsToState(event);
    }
  }

  Stream<ParkingLotsState> _mapFetchParkingLotsToState(FetchParkingLots event) async* {
    yield ParkingLotsLoading();
    try {
      final List<Map<String, dynamic>> parkingLots = [
        {"id": 1, "name": "Lot 1", "image": "http://example.com/lot1.jpg"},
        {"id": 2, "name": "Lot 2", "image": "http://example.com/lot2.jpg"},
      ]; // Example data
      yield ParkingLotsSuccess(Tuple2(parkingLots, parkingLots.length));
    } catch (_) {
      yield ParkingLotsFailure();
    }
  }


}