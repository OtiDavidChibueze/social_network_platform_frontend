import 'package:flutter/material.dart';

class DefaultShowModalBottomSheetWidget extends StatelessWidget {
  final List<Widget> elements;

  const DefaultShowModalBottomSheetWidget({super.key, required this.elements});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: elements),
    );
  }
}
