import 'package:flutter/material.dart';
import 'package:social_network_platform/core/common/widgets/default_button_widget.dart';
import 'package:social_network_platform/core/common/widgets/default_text_field_widget.dart';

class CreateMeetPage extends StatefulWidget {
  static const String route = '/create_meet';

  const CreateMeetPage({super.key});

  @override
  State<CreateMeetPage> createState() => _CreateMeetPageState();
}

class _CreateMeetPageState extends State<CreateMeetPage> {
  final TextEditingController _meetCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 10),

                DefaultTextFieldWidget(
                  hintText: 'Enter Meet title',
                  controller: _meetCtrl,
                ),
                SizedBox(height: 15),

                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                ),
                SizedBox(height: 15),

                Text(
                  'Time',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Events automatically mark as completed, 2 hours after they start.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Tap map to select location',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: .8),
                  ),
                ),

                SizedBox(height: 10),

                _buildLocationPicker(context),

                SizedBox(height: 28),

                DefaultButtonWidget(text: 'Create', onPressed: () {}),
              ],
            ),
          ),
        ),
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

  Widget _buildLocationPicker(BuildContext context) => Container(
    height: 360,
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.greenAccent.withValues(alpha: .5),
    ),
    // child: GoogleMap(
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
  );
}
