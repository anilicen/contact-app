import 'package:contact_app/constants.dart';
import 'package:contact_app/text_styles.dart';
import 'package:flutter/material.dart';

class EditBottomSheetTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final String? initialValue;
  final int index;
  const EditBottomSheetTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.initialValue,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: TextFormField(
        initialValue: initialValue,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: backgroundColor,
          hintText: hintText,
          hintStyle: getBold16(color: cpGray),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
