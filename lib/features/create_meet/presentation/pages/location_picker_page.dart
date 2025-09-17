import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_network_platform/core/common/widgets/default_button_widget.dart';
import 'package:social_network_platform/core/di/locator.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/location_picker/location_picker_bloc.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/location_picker/location_picker_event.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/location_picker/location_picker_state.dart';

class LocationPickerPage extends StatefulWidget {
  static const String route = '/location-picker';
  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocationPickerBloc>()..add(GetLocationEvent()),
      child: BlocConsumer<LocationPickerBloc, LocationPickerState>(
        listener: (context, state) {
          if (state.status == LocationPickerStatus.success &&
              state.location != null) {
            mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: state.location!, zoom: 10),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == LocationPickerStatus.loading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Select Location',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            body: Stack(
              children: [
                // GoogleMap(
                //   initialCameraPosition: CameraPosition(
                //     target: state.location ?? LatLng(40.730610, -73.934242),
                //     zoom: 10,
                //   ),
                //   myLocationEnabled: true,
                //   onCameraMove: (camera) {
                //     context.read<LocationPickerBloc>().add(
                //       SetLocationEvent(location: camera.target),
                //     );
                //   },
                //   onMapCreated: (controller) {
                //     mapController = controller;
                //   },
                // ),
                // Center(
                //   child: Icon(
                //     Icons.location_pin,
                //     color: Theme.of(context).colorScheme.error,
                //     size: 40,
                //   ),
                // ),

                // Positioned(
                //   bottom: 20,
                //   right: 20,
                //   left: 20,
                //   child: DefaultButtonWidget(
                //     text: 'Select',
                //     onPressed: state.location != null
                //         ? () {
                //             context.pop(state.location);
                //           }
                //         : null,
                //   ),
                // ),

                //* Sample demo display
                Center(
                  child: Text(
                    'Api Key missing to display Google Map',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
