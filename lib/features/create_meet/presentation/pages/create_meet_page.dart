import 'package:flutter/material.dart';

class CreateMeetPage extends StatelessWidget {
  static const String route = '/create_meet';

  const CreateMeetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Meet',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      body: SingleChildScrollView(child: Column(children: [
            
          ],
        )),
    );
  }
}
