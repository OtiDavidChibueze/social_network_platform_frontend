import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_network_platform/core/di/locator.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/create_meet/create_meet_bloc.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/create_meet/create_meet_event.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/create_meet/create_meet_state.dart';
import '../../../../core/common/widgets/default_button_widget.dart';
import '../../../../core/common/widgets/default_text_field_widget.dart';
import 'location_picker_page.dart';

class CreateMeetPage extends StatefulWidget {
  static const String route = '/create_meet';

  const CreateMeetPage({super.key});

  @override
  State<CreateMeetPage> createState() => _CreateMeetPageState();
}

class _CreateMeetPageState extends State<CreateMeetPage> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  GoogleMapController? _mapController;
  TimeOfDay timeOfDay = TimeOfDay.now();
  LatLng? location;
  final GlobalKey<FormState> _createMeetForm = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _clear() {
    _titleCtrl.clear();
    _descriptionCtrl.clear();

    setState(() {
      location = LatLng(0, 0);
      timeOfDay = TimeOfDay.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateMeetBloc>(),
      child: BlocConsumer<CreateMeetBloc, CreateMeetState>(
        listener: (context, state) {
          if (state.status == CreateMeetStatus.success) {}

          if (state.status == CreateMeetStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
          }
        },
        builder: (context, state) {
          if (state.status == CreateMeetStatus.loading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Create Meet',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Form(
                    key: _createMeetForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),

                        SizedBox(height: 10),

                        DefaultTextFieldWidget(
                          hintText: 'Enter Meet title',
                          controller: _titleCtrl,
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 15),

                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),

                        SizedBox(height: 10),

                        DefaultTextFieldWidget(
                          hintText: 'Enter Meet description',
                          controller: _descriptionCtrl,
                          maxLines: 255,
                          minLines: 2,
                          maxLenght: 6,
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),

                        SizedBox(height: 15),

                        Text(
                          'Time',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Events automatically mark as completed, 2 hours after they start.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: .8),
                              ),
                        ),

                        SizedBox(height: 18),

                        _buildTimePicker(context),

                        SizedBox(height: 15),

                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Tap map to select location',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: .8),
                              ),
                        ),

                        SizedBox(height: 10),

                        _buildLocationPicker(context),

                        SizedBox(height: 40),

                        DefaultButtonWidget(
                          text: 'Create',
                          onPressed:
                              location == null ||
                                  _titleCtrl.text.isEmpty ||
                                  _descriptionCtrl.text.isEmpty
                              ? null
                              : () {
                                  context.read<CreateMeetBloc>().add(
                                    CreateMeetEvent(
                                      title: _titleCtrl.text.trim(),
                                      description: _descriptionCtrl.text.trim(),
                                      time: timeOfDay,
                                      location: location!,
                                    ),
                                  );

                                  _clear();
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) => Row(
    children: [
      _buildTimePart(context, timeOfDay.hour),
      SizedBox(width: 5),

      Text(':', style: Theme.of(context).textTheme.bodyMedium),

      SizedBox(width: 5),

      _buildTimePart(context, timeOfDay.minute),
    ],
  );

  Widget _buildTimePart(BuildContext context, int value) => InkWell(
    onTap: () async {
      final time = await showTimePicker(
        context: context,
        initialTime: timeOfDay,
        initialEntryMode: TimePickerEntryMode.inputOnly,
      );

      if (time != null) {
        setState(() {
          timeOfDay = time;
        });
      }
    },

    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        value.toString().padLeft(2, '0'),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16),
      ),
    ),
  );

  Widget _buildLocationPicker(BuildContext context) => InkWell(
    onTap: () => context.push(LocationPickerPage.route),
    child: Container(
      height: 360,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.greenAccent.withValues(alpha: .5),
      ),

      // child: GoogleMap(
      //   myLocationEnabled: false,
      //   myLocationButtonEnabled: false,
      //   compassEnabled: false,
      //   scrollGesturesEnabled: false,
      //   zoomControlsEnabled: false,
      //   zoomGesturesEnabled: false,
      //   tiltGesturesEnabled: false,
      //   rotateGesturesEnabled: false,
      //   onMapCreated: (controller) {
      //     setState(() {
      //       _mapController = controller;
      //     });
      //   },
      //   onTap: (_) async {
      //     LatLng? selectedLocation = await context.push(LocationPickerPage.route);

      //     if (selectedLocation != null) {
      //       setState(() {
      //         location = selectedLocation;
      //       });

      //       _mapController?.animateCamera(
      //         CameraUpdate.newLatLngZoom(selectedLocation, 15),
      //       );
      //     }
      //   },
      //   markers: location != null
      //       ? {
      //           Marker(
      //             markerId: MarkerId('selectedLocation'),
      //             position: location!,
      //           ),
      //         }
      //       : {},
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(40.730610, -73.934242),
      //     zoom: 10,
      //   ),
      // ),
      child: Center(
        child: Text(
          'Api Key missing to display Google Map',
          style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
        ),
      ),
      // ),
    ),
  );
}
