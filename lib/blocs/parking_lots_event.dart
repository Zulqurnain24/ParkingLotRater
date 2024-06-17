import 'package:equatable/equatable.dart';

class ParkingLotsEvent extends Equatable {
  const ParkingLotsEvent();

  @override
  List<Object> get props => [];
}

class FetchParkingLots extends ParkingLotsEvent {
  final int pageSize;

  const FetchParkingLots(this.pageSize);

  @override
  List<Object> get props => [pageSize];
}