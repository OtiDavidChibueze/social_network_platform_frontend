import 'package:flutter/material.dart';

class DefaultTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? initialValue;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final int? maxLenght;
  final int? maxLines;
  final int? minLines;

  const DefaultTextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.prefixText,
    this.initialValue,
    this.onChanged,
    this.prefixIcon,
    this.maxLenght,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      minLines: minLines,
      maxLength: maxLenght,
      maxLines: maxLines,
      initialValue: initialValue,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurfaceVariant,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        counterStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide.none,
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide.none,
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide.none,
        // ),
      ),
    );
  }
}
