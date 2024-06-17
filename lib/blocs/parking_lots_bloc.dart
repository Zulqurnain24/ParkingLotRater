import 'package:bloc/bloc.dart';
import 'package:parking_lot_rater/repositories/parkinglots_repository.dart';
import 'package:tuple/tuple.dart';
import 'parking_lots_event.dart';
import 'parking_lots_state.dart';

class ParkingLotsBloc extends Bloc<ParkingLotsEvent, ParkingLotsState> {
  final ParkingLotsRepository parkingLotsRepository;

  ParkingLotsBloc(this.parkingLotsRepository) : super(ParkingLotsInitial()) {
    on<FetchParkingLots>(_onFetchParkingLots);
  }

  void _onFetchParkingLots(FetchParkingLots event, Emitter<ParkingLotsState> emit) async {
    emit(ParkingLotsLoading());
    try {
      final parkingLots = await parkingLotsRepository.fetchInitialParkingLots(event.pageSize);
      emit(ParkingLotsSuccess(
          parkingLots
      ));
    } catch (e) {
      emit(ParkingLotsFailure());
    }
  }

  @override
  Stream<ParkingLotsState> mapEventToState(ParkingLotsEvent event) async* {
    if (event is FetchParkingLots) {
      yield* _mapFetchParkingLotsToState(event);
    }
  }

  Stream<ParkingLotsState> _mapFetchParkingLotsToState(FetchParkingLots event) async* {
    yield ParkingLotsLoading();
    try {
      final parkingLots = await parkingLotsRepository.fetchInitialParkingLots(event.pageSize);
      yield ParkingLotsSuccess(
          parkingLots
      );
    } catch (_) {
      yield ParkingLotsFailure();
    }
  }
}
