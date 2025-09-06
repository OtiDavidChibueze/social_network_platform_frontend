import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_picker_event.dart';
import 'location_picker_state.dart';

class LocationPickerBloc
    extends Bloc<LocationPickerEvent, LocationPickerState> {
  LocationPickerBloc() : super(LocationPickerState.initial());
}
