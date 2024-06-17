import 'package:equatable/equatable.dart';
import 'package:tuple/tuple.dart';

sealed class ParkingLotsState extends Equatable {
  const ParkingLotsState();

  @override
  List<Object> get props => [];
}

final class ParkingLotsInitial extends ParkingLotsState {}

final class ParkingLotsFailure extends ParkingLotsState {}

final class ParkingLotsLoading extends ParkingLotsState {}

final class ParkingLotsSuccess extends ParkingLotsState {
  final Tuple2<List<Map<String, dynamic>>, int> parkingLots;

  const ParkingLotsSuccess(this.parkingLots);

  @override
  List<Object> get props => [parkingLots];
}
